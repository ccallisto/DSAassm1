with Ada.Text_IO; use Ada.Text_IO;
with Food_DataStructures ;use Food_DataStructures;

package body LinearAllocList is

   capacity := 21;
   subtype slotindex is natural range 0 ..(capacity -1);
   first, last: slotindex := 0;
   mesnum : Natural range 0..(Capacity-1):= 0;
   box : array(slotindex) of Food_Pack;
   max: Natural := capacity -1;
   
   procedure insert(msg: in Food_Pack) is
      begin
   pos := last;
   while pos > 0 and then box(pos - 1) > msg loop
      box(pos) := box(pos - 1); -- Shift elements to the right
      pos := pos - 1;
   end loop;

   box(pos):= msg;

      last := last + 1;
      if listFull = True then
        put("ERROR - Message rejected - list is full!"); new_line(2);
    end if;
   end insert;
   
   procedure retrieve(target :in Food_Pack; outitem : out Food_Pack)is
   begin
      index := slotindex;
      
      if not isEmpty then
      
         index := BinarySearch(box, target);
           
         -- if binarysearch finds an index (not -1?) then remove that value
         -- else send the index 0 and shift everything backward
         for i in 0..index
         loop
            box(pos-1) := box(pos);
         end loop;
         
         
      end if;
      --implement binarysearch to find particular index here
   end retrieve;
   
   function BinarySearch(box: in foodarray; Target: in Food_Pack) return slotindex;    
    low : slotindex := 0;
    high : slotindex := last - 1;
    middle : slotindex;
    
     while low <= high loop
         middle := (low+high)/2;
      if box(middle)> target then
            high := middle-1;
            
      else if box(middle) < target then
            low := middle + 1;
      else 
            return middle;  
      end if;           
     end loop;
    
    --put("food item not found sending first in list");
    return slotindex'First; --not found 
      
   end BinarySearch;
   
  function isFull return Boolean is
   begin
      if last = max then
      return True;
      else
      return False;
      end if;
      
   end isFull;
   
 function isEmpty return Boolean is
   begin
      if (first = 0) then
      return True;
      else
      return False;
      end if;
   end isEmpty;
   
end LinearAllocList;
