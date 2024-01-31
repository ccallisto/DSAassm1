with Ada.text_IO; use Ada.Text_IO;

generic
    type message is private;
    -- Add generic parameter to determine the size of the storage space.

 package CircularQue is

   procedure acceptMessage(msg: in message);

   procedure retrieveMessage(msg: out message);

   function circularQueEmpty return Boolean;

   function circularQueFull return Boolean;


 end CircularQue;
