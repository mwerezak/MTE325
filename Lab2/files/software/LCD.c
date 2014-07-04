#include <unistd.h>
#include <string.h>
#include <io.h>
#include "system.h"
#include "LCD.h"
//-------------------------------------------------------------------------
void LCD_Init()
{
  lcd_write_cmd(LCD_DISPLAY_BASE,0x38);
  usleep(2000);
  lcd_write_cmd(LCD_DISPLAY_BASE,0x0C);
  usleep(2000);
  lcd_write_cmd(LCD_DISPLAY_BASE,0x01);
  usleep(2000);
  lcd_write_cmd(LCD_DISPLAY_BASE,0x06);
  usleep(2000);
  lcd_write_cmd(LCD_DISPLAY_BASE,0x80);
  usleep(2000);
}
//-------------------------------------------------------------------------
void LCD_Show_Text(char* Text)
{
  int i;
  for(i=0;i<strlen(Text);i++)
  {
    lcd_write_data(LCD_DISPLAY_BASE,Text[i]);
    usleep(2000);
  }
}
//-------------------------------------------------------------------------
void LCD_Line2()
{
  lcd_write_cmd(LCD_DISPLAY_BASE,0xC0);
  usleep(2000);
}
//-------------------------------------------------------------------------
void LCD_Test()
{
  char Text1[16] = "1234567890 ABCD!";
  char Text2[16] = "dcba 0987654321!";
  //  Initial LCD
  LCD_Init();
  //  Show Text to LCD
  LCD_Show_Text(Text1);
  //  Change Line2
  LCD_Line2();
  //  Show Text to LCD
  LCD_Show_Text(Text2);
}
//-------------------------------------------------------------------------
void LCD_Display(char* Text1, int play_speed)
{
  char parsed_text[12];
  char Text2[16] = {0};
  int i;
  
  for(i=0;i<11;i++)
  {
    parsed_text[i] = Text1[i];
  }
  
  parsed_text[11] = '\0';
  
  switch (play_speed)
  {
    case 1:
    strcpy(Text2,"Double Speed");
    break;
    case 2:
    strcpy(Text2,"Half Speed");
    break;
    case 3:
    strcpy(Text2,"Delay");
    break;
    case 4:
    strcpy(Text2,"Reverse");
    break;
    default:
    strcpy(Text2,"Normal Speed");
    break;
  }
  
  LCD_Init();
  LCD_Show_Text(parsed_text);
  LCD_Line2();
  LCD_Show_Text(Text2);
}

//-------------------------------------------------------------------------
void LCD_File_Buffering(char* Text)
{
  char parsed_text[12];
  char Text2[16] = {"Buffering"};
  int i;
    
  for(i=0;i<11;i++)
  {
    parsed_text[i] = Text[i];
  }
    
  parsed_text[11] = '\0';
  
  LCD_Init();
  LCD_Show_Text(parsed_text);
  LCD_Line2();
  LCD_Show_Text(Text2);
}
