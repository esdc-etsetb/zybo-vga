-- Simple object representation on VGA screen
-- First version: F. MOll UPC May 2018 (not tested, use at your own risk)


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;


ENTITY screen_object IS

	PORT(cx, cy		: IN	STD_LOGIC_VECTOR(5 downto 0); -- 64x64 object position 
		 pixel_row, pixel_column		: IN STD_LOGIC_VECTOR(9 DOWNTO 0); -- coming from VGA _SYNC
		 pixel_color : OUT STD_LOGIC_VECTOR(2 downto 0) -- object pixels
		 ); -- video memory address counter

END screen_object;

ARCHITECTURE a OF screen_object IS
	CONSTANT color_out : STD_LOGIC_VECTOR(2 downto 0) := "001"; -- color Blue
	-- object position mask in 64x64 grid (16x16 pixels)
	SIGNAL paint_object		: STD_LOGIC;
	-- detailed object shape
	SIGNAL object_shape		: STD_LOGIC;

BEGIN

	-- check object coordinates against pixel row/column
	paint_object <= (cx = pixel_column(9 downto 4)) AND (cy = pixel_row(9 downto 4));
	
	-- Object shape. Example: square 8x8 pixels
	object_shape <= paint_object and pixel_column(3) and pixel_row(3);
	-- Another example: checkerboard
	-- object_shape <= paint_object and (pixel_column(2) xor pixel_row(2));
		
	pixel_color <= color_out when object_shape='1'
					else "000";
	
END architecture a;