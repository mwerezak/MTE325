#include <io.h>
#include <stdio.h>
#include "system.h"
#include "Open_I2C.h"
//-------------------------------------------------------------------------
unsigned int I2C_Read_Period()
{
  unsigned char low,high;
  low = IORD(OPEN_I2C_0_BASE,I2C_PRER_LO);
  high= IORD(OPEN_I2C_0_BASE,I2C_PRER_HI);
  return (high<<16)+low;
}
//-------------------------------------------------------------------------
unsigned char I2C_Read_Ctrl()
{
  return  IORD(OPEN_I2C_0_BASE,I2C_CTR);
}
//-------------------------------------------------------------------------
unsigned char I2C_Read_RX()
{
  return  IORD(OPEN_I2C_0_BASE,I2C_RXR);
}
//-------------------------------------------------------------------------
unsigned char I2C_Read_Status()
{
  return  IORD(OPEN_I2C_0_BASE,I2C_SR);
}
//-------------------------------------------------------------------------
void I2C_Write_Period(unsigned int Period)
{
  IOWR(OPEN_I2C_0_BASE,I2C_PRER_LO,Period&0xFF);
  IOWR(OPEN_I2C_0_BASE,I2C_PRER_HI,Period>>16);
}
//-------------------------------------------------------------------------
void  I2C_Write_Ctrl(unsigned char value)
{
  IOWR(OPEN_I2C_0_BASE,I2C_CTR,value);
}
//-------------------------------------------------------------------------
void  I2C_Write_TX(unsigned char value)
{
  IOWR(OPEN_I2C_0_BASE,I2C_TXR,value);
}
//-------------------------------------------------------------------------
void  I2C_Write_CMD(unsigned char value)
{
  IOWR(OPEN_I2C_0_BASE,I2C_CR,value);
}
//-------------------------------------------------------------------------
unsigned char I2C_Read_CMD()
{
  return  IORD(OPEN_I2C_0_BASE, I2C_CR);
}
//-------------------------------------------------------------------------
void  I2C_Init(unsigned int Period)
{
  I2C_Ctrl_Reg  a;
  I2C_Write_Period(Period);
  a.I2C_Ctrl_Flags.CORE_ENABLE=1;
  a.I2C_Ctrl_Flags.INT_ENABLE=1;
  a.I2C_Ctrl_Flags.RESERVED=0;
  I2C_Write_Ctrl(a.Value);
}
//-------------------------------------------------------------------------
unsigned char I2C_Send(unsigned char value,unsigned char STA,unsigned char STO)
{
  unsigned char ACK;
  I2C_CMD_Reg     I2C_CMD;
  I2C_Status_Reg  I2C_Status;
  //IOWR(LEDR_PIO_BASE, 0, 7); //THREE LEDS
  I2C_Write_TX(value);
  //IOWR(LEDR_PIO_BASE, 0, 15); //FOUR LEDS
  I2C_CMD.Value=0;
  if(STA!=0)
    I2C_CMD.I2C_CMD_Flags.STA=1;
  if(STO!=0)
    I2C_CMD.I2C_CMD_Flags.STO=1;
  I2C_CMD.I2C_CMD_Flags.WR=1;
  I2C_Write_CMD(I2C_CMD.Value);
  
  //ACK = I2C_Read_CMD();
  //printf("cmd = %d\nreal cmd = %d\n", ACK, I2C_CMD.Value);
  
  //IOWR(LEDR_PIO_BASE, 0, 31); //FIVE LEDS
  
  //I2C_Status.Value=I2C_Read_Status();
  //printf("sr = %d\n", I2C_Status.Value);
  
  do
  {
    I2C_Status.Value=I2C_Read_Status();
  }
  while(I2C_Status.I2C_Status_Flags.TIP);
  //IOWR(LEDR_PIO_BASE, 0, 63); //SIX LEDS
  if(!I2C_Status.I2C_Status_Flags.RXACK)
  ACK=1;
  else
  ACK=0;
  return ACK;
}
//-------------------------------------------------------------------------

