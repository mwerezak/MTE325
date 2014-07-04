/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu_0' in SOPC Builder design 'my_controller'
 * SOPC Builder design path: N:/MTE325/Lab2/my_controller.sopcinfo
 *
 * Generated: Fri Jul 04 14:29:46 EDT 2014
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x1000820
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x0
#define ALT_CPU_CPU_IMPLEMENTATION "small"
#define ALT_CPU_DATA_ADDR_WIDTH 0x19
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x800020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INST_ADDR_WIDTH 0x19
#define ALT_CPU_NAME "cpu_0"
#define ALT_CPU_RESET_ADDR 0x800000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x1000820
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x0
#define NIOS2_CPU_IMPLEMENTATION "small"
#define NIOS2_DATA_ADDR_WIDTH 0x19
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x800020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INST_ADDR_WIDTH 0x19
#define NIOS2_RESET_ADDR 0x800000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_LCD_16207
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID
#define __ALTERA_AVALON_TIMER
#define __ALTERA_NIOS2
#define __AUDIO
#define __OPEN_I2C


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "CYCLONEII"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x1001138
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x1001138
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x1001138
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "my_controller"


/*
 * aud_full configuration
 *
 */

#define ALT_MODULE_CLASS_aud_full altera_avalon_pio
#define AUD_FULL_BASE 0x10010f0
#define AUD_FULL_BIT_CLEARING_EDGE_REGISTER 0
#define AUD_FULL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define AUD_FULL_CAPTURE 0
#define AUD_FULL_DATA_WIDTH 1
#define AUD_FULL_DO_TEST_BENCH_WIRING 0
#define AUD_FULL_DRIVEN_SIM_VALUE 0x0
#define AUD_FULL_EDGE_TYPE "NONE"
#define AUD_FULL_FREQ 50000000u
#define AUD_FULL_HAS_IN 1
#define AUD_FULL_HAS_OUT 0
#define AUD_FULL_HAS_TRI 0
#define AUD_FULL_IRQ -1
#define AUD_FULL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define AUD_FULL_IRQ_TYPE "NONE"
#define AUD_FULL_NAME "/dev/aud_full"
#define AUD_FULL_RESET_VALUE 0x0
#define AUD_FULL_SPAN 16
#define AUD_FULL_TYPE "altera_avalon_pio"


/*
 * audio_0 configuration
 *
 */

#define ALT_MODULE_CLASS_audio_0 audio
#define AUDIO_0_BASE 0x1001140
#define AUDIO_0_IRQ -1
#define AUDIO_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define AUDIO_0_NAME "/dev/audio_0"
#define AUDIO_0_SPAN 4
#define AUDIO_0_TYPE "audio"


/*
 * button_pio configuration
 *
 */

#define ALT_MODULE_CLASS_button_pio altera_avalon_pio
#define BUTTON_PIO_BASE 0x1001090
#define BUTTON_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define BUTTON_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BUTTON_PIO_CAPTURE 1
#define BUTTON_PIO_DATA_WIDTH 4
#define BUTTON_PIO_DO_TEST_BENCH_WIRING 0
#define BUTTON_PIO_DRIVEN_SIM_VALUE 0x0
#define BUTTON_PIO_EDGE_TYPE "ANY"
#define BUTTON_PIO_FREQ 50000000u
#define BUTTON_PIO_HAS_IN 1
#define BUTTON_PIO_HAS_OUT 0
#define BUTTON_PIO_HAS_TRI 0
#define BUTTON_PIO_IRQ 1
#define BUTTON_PIO_IRQ_INTERRUPT_CONTROLLER_ID 0
#define BUTTON_PIO_IRQ_TYPE "EDGE"
#define BUTTON_PIO_NAME "/dev/button_pio"
#define BUTTON_PIO_RESET_VALUE 0x0
#define BUTTON_PIO_SPAN 16
#define BUTTON_PIO_TYPE "altera_avalon_pio"


/*
 * green_led_pio configuration
 *
 */

#define ALT_MODULE_CLASS_green_led_pio altera_avalon_pio
#define GREEN_LED_PIO_BASE 0x10010a0
#define GREEN_LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define GREEN_LED_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define GREEN_LED_PIO_CAPTURE 0
#define GREEN_LED_PIO_DATA_WIDTH 8
#define GREEN_LED_PIO_DO_TEST_BENCH_WIRING 0
#define GREEN_LED_PIO_DRIVEN_SIM_VALUE 0x0
#define GREEN_LED_PIO_EDGE_TYPE "NONE"
#define GREEN_LED_PIO_FREQ 50000000u
#define GREEN_LED_PIO_HAS_IN 0
#define GREEN_LED_PIO_HAS_OUT 1
#define GREEN_LED_PIO_HAS_TRI 0
#define GREEN_LED_PIO_IRQ -1
#define GREEN_LED_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define GREEN_LED_PIO_IRQ_TYPE "NONE"
#define GREEN_LED_PIO_NAME "/dev/green_led_pio"
#define GREEN_LED_PIO_RESET_VALUE 0x0
#define GREEN_LED_PIO_SPAN 16
#define GREEN_LED_PIO_TYPE "altera_avalon_pio"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK TIMER_0
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x1001138
#define JTAG_UART_0_IRQ 0
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * lcd_display configuration
 *
 */

#define ALT_MODULE_CLASS_lcd_display altera_avalon_lcd_16207
#define LCD_DISPLAY_BASE 0x1001060
#define LCD_DISPLAY_IRQ -1
#define LCD_DISPLAY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LCD_DISPLAY_NAME "/dev/lcd_display"
#define LCD_DISPLAY_SPAN 16
#define LCD_DISPLAY_TYPE "altera_avalon_lcd_16207"


/*
 * led_pio configuration
 *
 */

#define ALT_MODULE_CLASS_led_pio altera_avalon_pio
#define LED_PIO_BASE 0x1001070
#define LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define LED_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LED_PIO_CAPTURE 0
#define LED_PIO_DATA_WIDTH 8
#define LED_PIO_DO_TEST_BENCH_WIRING 0
#define LED_PIO_DRIVEN_SIM_VALUE 0x0
#define LED_PIO_EDGE_TYPE "NONE"
#define LED_PIO_FREQ 50000000u
#define LED_PIO_HAS_IN 0
#define LED_PIO_HAS_OUT 1
#define LED_PIO_HAS_TRI 0
#define LED_PIO_IRQ -1
#define LED_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LED_PIO_IRQ_TYPE "NONE"
#define LED_PIO_NAME "/dev/led_pio"
#define LED_PIO_RESET_VALUE 0x0
#define LED_PIO_SPAN 16
#define LED_PIO_TYPE "altera_avalon_pio"


/*
 * open_i2c_0 configuration
 *
 */

#define ALT_MODULE_CLASS_open_i2c_0 open_i2c
#define OPEN_I2C_0_BASE 0x1001040
#define OPEN_I2C_0_IRQ 4
#define OPEN_I2C_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define OPEN_I2C_0_NAME "/dev/open_i2c_0"
#define OPEN_I2C_0_SPAN 32
#define OPEN_I2C_0_TYPE "open_i2c"


/*
 * red_led_pio configuration
 *
 */

#define ALT_MODULE_CLASS_red_led_pio altera_avalon_pio
#define RED_LED_PIO_BASE 0x10010b0
#define RED_LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define RED_LED_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RED_LED_PIO_CAPTURE 0
#define RED_LED_PIO_DATA_WIDTH 8
#define RED_LED_PIO_DO_TEST_BENCH_WIRING 0
#define RED_LED_PIO_DRIVEN_SIM_VALUE 0x0
#define RED_LED_PIO_EDGE_TYPE "NONE"
#define RED_LED_PIO_FREQ 50000000u
#define RED_LED_PIO_HAS_IN 0
#define RED_LED_PIO_HAS_OUT 1
#define RED_LED_PIO_HAS_TRI 0
#define RED_LED_PIO_IRQ -1
#define RED_LED_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RED_LED_PIO_IRQ_TYPE "NONE"
#define RED_LED_PIO_NAME "/dev/red_led_pio"
#define RED_LED_PIO_RESET_VALUE 0x0
#define RED_LED_PIO_SPAN 16
#define RED_LED_PIO_TYPE "altera_avalon_pio"


/*
 * sd_clk configuration
 *
 */

#define ALT_MODULE_CLASS_sd_clk altera_avalon_pio
#define SD_CLK_BASE 0x1001120
#define SD_CLK_BIT_CLEARING_EDGE_REGISTER 0
#define SD_CLK_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SD_CLK_CAPTURE 0
#define SD_CLK_DATA_WIDTH 1
#define SD_CLK_DO_TEST_BENCH_WIRING 0
#define SD_CLK_DRIVEN_SIM_VALUE 0x0
#define SD_CLK_EDGE_TYPE "NONE"
#define SD_CLK_FREQ 50000000u
#define SD_CLK_HAS_IN 0
#define SD_CLK_HAS_OUT 1
#define SD_CLK_HAS_TRI 0
#define SD_CLK_IRQ -1
#define SD_CLK_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SD_CLK_IRQ_TYPE "NONE"
#define SD_CLK_NAME "/dev/sd_clk"
#define SD_CLK_RESET_VALUE 0x0
#define SD_CLK_SPAN 16
#define SD_CLK_TYPE "altera_avalon_pio"


/*
 * sd_cmd configuration
 *
 */

#define ALT_MODULE_CLASS_sd_cmd altera_avalon_pio
#define SD_CMD_BASE 0x1001110
#define SD_CMD_BIT_CLEARING_EDGE_REGISTER 0
#define SD_CMD_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SD_CMD_CAPTURE 0
#define SD_CMD_DATA_WIDTH 1
#define SD_CMD_DO_TEST_BENCH_WIRING 0
#define SD_CMD_DRIVEN_SIM_VALUE 0x0
#define SD_CMD_EDGE_TYPE "NONE"
#define SD_CMD_FREQ 50000000u
#define SD_CMD_HAS_IN 0
#define SD_CMD_HAS_OUT 0
#define SD_CMD_HAS_TRI 1
#define SD_CMD_IRQ -1
#define SD_CMD_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SD_CMD_IRQ_TYPE "NONE"
#define SD_CMD_NAME "/dev/sd_cmd"
#define SD_CMD_RESET_VALUE 0x0
#define SD_CMD_SPAN 16
#define SD_CMD_TYPE "altera_avalon_pio"


/*
 * sd_dat configuration
 *
 */

#define ALT_MODULE_CLASS_sd_dat altera_avalon_pio
#define SD_DAT_BASE 0x1001100
#define SD_DAT_BIT_CLEARING_EDGE_REGISTER 0
#define SD_DAT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SD_DAT_CAPTURE 0
#define SD_DAT_DATA_WIDTH 1
#define SD_DAT_DO_TEST_BENCH_WIRING 0
#define SD_DAT_DRIVEN_SIM_VALUE 0x0
#define SD_DAT_EDGE_TYPE "NONE"
#define SD_DAT_FREQ 50000000u
#define SD_DAT_HAS_IN 0
#define SD_DAT_HAS_OUT 0
#define SD_DAT_HAS_TRI 1
#define SD_DAT_IRQ -1
#define SD_DAT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SD_DAT_IRQ_TYPE "NONE"
#define SD_DAT_NAME "/dev/sd_dat"
#define SD_DAT_RESET_VALUE 0x0
#define SD_DAT_SPAN 16
#define SD_DAT_TYPE "altera_avalon_pio"


/*
 * sdram_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sdram_0 altera_avalon_new_sdram_controller
#define SDRAM_0_BASE 0x800000
#define SDRAM_0_CAS_LATENCY 3
#define SDRAM_0_CONTENTS_INFO ""
#define SDRAM_0_INIT_NOP_DELAY 0.0
#define SDRAM_0_INIT_REFRESH_COMMANDS 2
#define SDRAM_0_IRQ -1
#define SDRAM_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_0_IS_INITIALIZED 1
#define SDRAM_0_NAME "/dev/sdram_0"
#define SDRAM_0_POWERUP_DELAY 100.0
#define SDRAM_0_REFRESH_PERIOD 15.625
#define SDRAM_0_REGISTER_DATA_IN 1
#define SDRAM_0_SDRAM_ADDR_WIDTH 0x16
#define SDRAM_0_SDRAM_BANK_WIDTH 2
#define SDRAM_0_SDRAM_COL_WIDTH 8
#define SDRAM_0_SDRAM_DATA_WIDTH 16
#define SDRAM_0_SDRAM_NUM_BANKS 4
#define SDRAM_0_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_0_SDRAM_ROW_WIDTH 12
#define SDRAM_0_SHARED_DATA 0
#define SDRAM_0_SIM_MODEL_BASE 0
#define SDRAM_0_SPAN 8388608
#define SDRAM_0_STARVATION_INDICATOR 0
#define SDRAM_0_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_0_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_0_T_AC 5.5
#define SDRAM_0_T_MRD 3
#define SDRAM_0_T_RCD 20.0
#define SDRAM_0_T_RFC 70.0
#define SDRAM_0_T_RP 20.0
#define SDRAM_0_T_WR 14.0


/*
 * seven_seg_middle_pio configuration
 *
 */

#define ALT_MODULE_CLASS_seven_seg_middle_pio altera_avalon_pio
#define SEVEN_SEG_MIDDLE_PIO_BASE 0x10010c0
#define SEVEN_SEG_MIDDLE_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define SEVEN_SEG_MIDDLE_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SEVEN_SEG_MIDDLE_PIO_CAPTURE 0
#define SEVEN_SEG_MIDDLE_PIO_DATA_WIDTH 16
#define SEVEN_SEG_MIDDLE_PIO_DO_TEST_BENCH_WIRING 0
#define SEVEN_SEG_MIDDLE_PIO_DRIVEN_SIM_VALUE 0x0
#define SEVEN_SEG_MIDDLE_PIO_EDGE_TYPE "NONE"
#define SEVEN_SEG_MIDDLE_PIO_FREQ 50000000u
#define SEVEN_SEG_MIDDLE_PIO_HAS_IN 0
#define SEVEN_SEG_MIDDLE_PIO_HAS_OUT 1
#define SEVEN_SEG_MIDDLE_PIO_HAS_TRI 0
#define SEVEN_SEG_MIDDLE_PIO_IRQ -1
#define SEVEN_SEG_MIDDLE_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SEVEN_SEG_MIDDLE_PIO_IRQ_TYPE "NONE"
#define SEVEN_SEG_MIDDLE_PIO_NAME "/dev/seven_seg_middle_pio"
#define SEVEN_SEG_MIDDLE_PIO_RESET_VALUE 0x0
#define SEVEN_SEG_MIDDLE_PIO_SPAN 16
#define SEVEN_SEG_MIDDLE_PIO_TYPE "altera_avalon_pio"


/*
 * seven_seg_pio configuration
 *
 */

#define ALT_MODULE_CLASS_seven_seg_pio altera_avalon_pio
#define SEVEN_SEG_PIO_BASE 0x1001080
#define SEVEN_SEG_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define SEVEN_SEG_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SEVEN_SEG_PIO_CAPTURE 0
#define SEVEN_SEG_PIO_DATA_WIDTH 16
#define SEVEN_SEG_PIO_DO_TEST_BENCH_WIRING 0
#define SEVEN_SEG_PIO_DRIVEN_SIM_VALUE 0x0
#define SEVEN_SEG_PIO_EDGE_TYPE "NONE"
#define SEVEN_SEG_PIO_FREQ 50000000u
#define SEVEN_SEG_PIO_HAS_IN 0
#define SEVEN_SEG_PIO_HAS_OUT 1
#define SEVEN_SEG_PIO_HAS_TRI 0
#define SEVEN_SEG_PIO_IRQ -1
#define SEVEN_SEG_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SEVEN_SEG_PIO_IRQ_TYPE "NONE"
#define SEVEN_SEG_PIO_NAME "/dev/seven_seg_pio"
#define SEVEN_SEG_PIO_RESET_VALUE 0x0
#define SEVEN_SEG_PIO_SPAN 16
#define SEVEN_SEG_PIO_TYPE "altera_avalon_pio"


/*
 * seven_seg_right_pio configuration
 *
 */

#define ALT_MODULE_CLASS_seven_seg_right_pio altera_avalon_pio
#define SEVEN_SEG_RIGHT_PIO_BASE 0x10010d0
#define SEVEN_SEG_RIGHT_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define SEVEN_SEG_RIGHT_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SEVEN_SEG_RIGHT_PIO_CAPTURE 0
#define SEVEN_SEG_RIGHT_PIO_DATA_WIDTH 32
#define SEVEN_SEG_RIGHT_PIO_DO_TEST_BENCH_WIRING 0
#define SEVEN_SEG_RIGHT_PIO_DRIVEN_SIM_VALUE 0x0
#define SEVEN_SEG_RIGHT_PIO_EDGE_TYPE "NONE"
#define SEVEN_SEG_RIGHT_PIO_FREQ 50000000u
#define SEVEN_SEG_RIGHT_PIO_HAS_IN 0
#define SEVEN_SEG_RIGHT_PIO_HAS_OUT 1
#define SEVEN_SEG_RIGHT_PIO_HAS_TRI 0
#define SEVEN_SEG_RIGHT_PIO_IRQ -1
#define SEVEN_SEG_RIGHT_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SEVEN_SEG_RIGHT_PIO_IRQ_TYPE "NONE"
#define SEVEN_SEG_RIGHT_PIO_NAME "/dev/seven_seg_right_pio"
#define SEVEN_SEG_RIGHT_PIO_RESET_VALUE 0x0
#define SEVEN_SEG_RIGHT_PIO_SPAN 16
#define SEVEN_SEG_RIGHT_PIO_TYPE "altera_avalon_pio"


/*
 * switch_pio configuration
 *
 */

#define ALT_MODULE_CLASS_switch_pio altera_avalon_pio
#define SWITCH_PIO_BASE 0x10010e0
#define SWITCH_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define SWITCH_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SWITCH_PIO_CAPTURE 0
#define SWITCH_PIO_DATA_WIDTH 16
#define SWITCH_PIO_DO_TEST_BENCH_WIRING 0
#define SWITCH_PIO_DRIVEN_SIM_VALUE 0x0
#define SWITCH_PIO_EDGE_TYPE "NONE"
#define SWITCH_PIO_FREQ 50000000u
#define SWITCH_PIO_HAS_IN 1
#define SWITCH_PIO_HAS_OUT 0
#define SWITCH_PIO_HAS_TRI 0
#define SWITCH_PIO_IRQ -1
#define SWITCH_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SWITCH_PIO_IRQ_TYPE "NONE"
#define SWITCH_PIO_NAME "/dev/switch_pio"
#define SWITCH_PIO_RESET_VALUE 0x0
#define SWITCH_PIO_SPAN 16
#define SWITCH_PIO_TYPE "altera_avalon_pio"


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid
#define SYSID_BASE 0x1001130
#define SYSID_ID 0u
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1403719567u
#define SYSID_TYPE "altera_avalon_sysid"


/*
 * timer_0 configuration
 *
 */

#define ALT_MODULE_CLASS_timer_0 altera_avalon_timer
#define TIMER_0_ALWAYS_RUN 0
#define TIMER_0_BASE 0x1001000
#define TIMER_0_COUNTER_SIZE 32
#define TIMER_0_FIXED_PERIOD 0
#define TIMER_0_FREQ 50000000u
#define TIMER_0_IRQ 2
#define TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_0_LOAD_VALUE 49999ull
#define TIMER_0_MULT 0.0010
#define TIMER_0_NAME "/dev/timer_0"
#define TIMER_0_PERIOD 1
#define TIMER_0_PERIOD_UNITS "ms"
#define TIMER_0_RESET_OUTPUT 0
#define TIMER_0_SNAPSHOT 1
#define TIMER_0_SPAN 32
#define TIMER_0_TICKS_PER_SEC 1000u
#define TIMER_0_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_0_TYPE "altera_avalon_timer"


/*
 * timer_1 configuration
 *
 */

#define ALT_MODULE_CLASS_timer_1 altera_avalon_timer
#define TIMER_1_ALWAYS_RUN 0
#define TIMER_1_BASE 0x1001020
#define TIMER_1_COUNTER_SIZE 32
#define TIMER_1_FIXED_PERIOD 0
#define TIMER_1_FREQ 50000000u
#define TIMER_1_IRQ 3
#define TIMER_1_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_1_LOAD_VALUE 499ull
#define TIMER_1_MULT 1.0E-6
#define TIMER_1_NAME "/dev/timer_1"
#define TIMER_1_PERIOD 10
#define TIMER_1_PERIOD_UNITS "us"
#define TIMER_1_RESET_OUTPUT 0
#define TIMER_1_SNAPSHOT 1
#define TIMER_1_SPAN 32
#define TIMER_1_TICKS_PER_SEC 100000u
#define TIMER_1_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_1_TYPE "altera_avalon_timer"

#endif /* __SYSTEM_H_ */
