.detect_sid
		sei
!if (BITFIRE_PLATFORM = BITFIRE_C64) {
		lda #$00
		sta $d015
}
		lda #$ff
!if (BITFIRE_PLATFORM = BITFIRE_C64) {
		cmp $d012
} else {
		cmp $ff1d
}
		bne *-3

		lda #$ff
		sta BITFIRE_SID+$12
		sta BITFIRE_SID+$0e
		sta BITFIRE_SID+$0f
		lda #$20
		sta BITFIRE_SID+$12
		lda BITFIRE_SID+$1b
		eor #$01
		and #$01
		ora link_chip_types	;0 = old, 1 = new sid
		sta link_chip_types

!if (BITFIRE_PLATFORM = BITFIRE_C64) {
.detect_cia
		;lda $d011
		;bmi *-3
		;lda $d011
		;bpl *-3

		sei
		lda #$35
		sta $01
		lda #<.detect_2
		sta $fffa
		lda #>.detect_2
		sta $fffb

		lda $dd0d
		lda #$81
		sta $dd0d

		lda #$04
		sta $dd04
		lda #$00
		sta $dd05

		sta $02

		lda #%10011001
		sta $dd0e

		lda $dd0d
		lda $dd0d
		inc $02
		jmp *

.detect_2
		lda $dd0d
		pla
		pla
		pla
		lda $02
		asl
		eor #$02
		ora link_chip_types
		sta link_chip_types

		lda #$37
		sta $01
}