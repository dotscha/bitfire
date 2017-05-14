!ifndef BITFIRE_IS_INCLUDED {
!src "loader_acme.inc"
}
bitfire_reset_drive_
!zone {
                ldy #.upload_size - 1
		;check if drive is idle
!if (BITFIRE_PLATFORM = BITFIRE_C64) {
                bit $dd00
                bpl *-3
} else {
		bit $01
		bpl *-2
}

		;upload data
-
        lda .upload_start,y
        jsr bitfire_send_byte_
		;waste cycles to be sure drive keeps up
		dey
        bpl -
.waste
		rts

.upload_start
!pseudopc $0108 {
.code_start
		;code to be uploaded goes here
		;jmp $eaa0
		jmp ($fffc)
.code_end
}
.code_size = .code_end - .code_start;

        !byte >(.code_size - 1), <(.code_size - 1)
		!byte >(.code_end - 1),  <(.code_end - 1)
		!byte BITFIRE_UPLOAD
.upload_end
.upload_size = .upload_end - .upload_start;
}
