onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Snake_test/CLOCK_PERIOD
add wave -noupdate /Snake_test/CLOCK_PERIOD
add wave -noupdate /Snake_test/clk
add wave -noupdate /Snake_test/KEY
add wave -noupdate /Snake_test/LEDR
add wave -noupdate /Snake_test/GPIO_1
add wave -noupdate /Snake_test/finalGrn
add wave -noupdate /Snake_test/finalRed
add wave -noupdate /Snake_test/SW
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 38
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1134 ps}
