with Ada.text_IO; use Ada.Text_IO;
generic 
   type message is private;
   
package linearalloclist is
   
   procedure insert(msg: in message);
     
   procedure remove(msg: in message);
   
   function get return Integer;
   
   function isFull return Boolean;
   
   function isEmpty return Boolean;
   
end linearalloclist;
   
