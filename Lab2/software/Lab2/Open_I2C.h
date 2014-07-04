#ifndef __Open_I2C_H__
#define __Open_I2C_H__

//  Open_I2C
#define I2C_PRER_LO 0
#define I2C_PRER_HI 1
#define I2C_CTR     2
#define I2C_TXR     3
#define I2C_RXR     3
#define I2C_CR      4
#define I2C_SR      4
//-------------------------------------------------------------------------
typedef union _I2C_Ctrl_Reg
{
  struct _I2C_Ctrl_Flags
  {
    unsigned char RESERVED    : 6;
    unsigned char INT_ENABLE  : 1;
    unsigned char CORE_ENABLE : 1;
  }I2C_Ctrl_Flags;
  
  unsigned char Value;
}I2C_Ctrl_Reg;
//-------------------------------------------------------------------------
typedef union _I2C_CMD_Reg
{
  struct _I2C_CMD_Flags
  {
    unsigned char IACK      : 1;
    unsigned char RESERVED  : 2;
    unsigned char ACK       : 1;
    unsigned char WR        : 1;
    unsigned char RD        : 1;
    unsigned char STO       : 1;
    unsigned char STA       : 1;
  }I2C_CMD_Flags;
  
  unsigned char Value;
}I2C_CMD_Reg;
//-------------------------------------------------------------------------
typedef union _I2C_Status_Reg
{
  struct _I2C_Status_Flags
  {
    unsigned char IF        : 1;
    unsigned char TIP       : 1;
    unsigned char RESERVED  : 3;
    unsigned char AL        : 1;
    unsigned char BUSY      : 1;
    unsigned char RXACK     : 1;
  }I2C_Status_Flags;
  
  unsigned char Value;
}I2C_Status_Reg;
//-------------------------------------------------------------------------
unsigned int  I2C_Read_Period();
unsigned char I2C_Read_Ctrl();
unsigned char I2C_Read_RX();
unsigned char I2C_Read_Status();
void          I2C_Write_Period(unsigned int Period);
void          I2C_Write_Ctrl(unsigned char value);
void          I2C_Write_TX(unsigned char value);
void          I2C_Write_CMD(unsigned char value);
void          I2C_Init(unsigned int Period);
unsigned char I2C_Send(unsigned char value,unsigned char STA,unsigned char STO);
//-------------------------------------------------------------------------

#endif
