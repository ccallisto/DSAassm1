with Ada.Text_IO use Ada.Text_IO;
with Food_DataStructures use Food_DataStructures;

package body LinearAllocList is
   if isFull = False then
   
   capacity Natural := 21; 
   subtype slotindex is natural range0..(capacity -1);
   first, last: slotindex := 0
   mesnum : Natural range 0..(Capacity-1):= 0
   box : array(slotindex) of message;
   max: Natural := capacity -1;
   
   procedure insert(msg: in message) is 
   pos := last;
   while pos > 0 and then box(pos - 1) > msg loop
      box(pos) := box(pos - 1); -- Shift elements to the right
      pos := pos - 1;
   end loop;

   box(pos) := msg;

         last := last + 1;
      else 
         put("ERROR - Message rejected - list is full!"); new_line(2);
    end if;
   end insert;
   
   procedure remove(msg : out message)is
   begin
      --implement binarysearch to find particular index here
   end remove;
   
   function BinarySearch(arr : in array of message; target : in message) return slotindex is
    low : slotindex := 0;
    high : slotindex := last - 1;
    middle : slotindex;
      
      
      
    end BinarySearch
   function isFull return Boolean is
   begin
      if (last = max)
      return True;
      else
      return False;
      end if;
      
   end isFull;
   
   function isEmpty return Boolean is
   begin
   
   end isEmpty;
   
end LinearAllocList;
