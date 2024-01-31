with Ada.Text_IO; use Ada.Text_IO;
with Food_DataStructures ;use Food_DataStructures;

package body LinearAllocList is

   first, last, pos: slotindex := 0;
   mesnum : Natural range 0..(Capacity-1):= 0;
   box : array(slotindex) of Food_Pack;
   max: Natural := capacity -1;
   
   procedure insert(msg: in Food_Pack) is
      begin
   pos := last;
   while pos > 0 and then greaterthan(getFood_PackFoodType(box(pos - 1)), getFood_PackFoodType(msg)) loop
      box(pos) := box(pos - 1); -- Shift elements to the right
      pos := pos - 1;
   end loop;

   box(pos):= msg;

      last := last + 1;
      if isFull then
        put("ERROR - Message rejected - list is full!"); new_line(2);
    end if;
   end insert;
   
procedure retrieve(target : in Food_Pack; outitem: out Food_Pack) is
      index : slotindex;
      
begin
   if not isEmpty then
      -- Find the index of the target item
      index := BinarySearch(box, target);

      -- Check if the item was found
      if index /= slotindex'First then  -- Assuming slotindex'First is your 'not found' indicator
         -- Set the out parameter
         outitem := box(index);

         -- Shift elements in the array
         for i in index .. last - 2 loop
            box(i) := box(i + 1);
         end loop;

         -- Adjust the 'last' pointer
         last := last - 1;
      else
         -- Item not found, handle accordingly
         outitem := box(0);  -- Or however you wish to handle this case
      end if;
   else
      outitem := box(0);  -- Or however you wish to handle this case
   end if;
end retrieve;
   
   function BinarySearch(box: in foodarray; Target: in Food_Pack) return slotindex is
    
    low : slotindex := 0;
    high : slotindex := last - 1;
    middle : slotindex;
    begin
     while low <= high loop
         middle := (low+high)/2;
      if greaterthan(getFood_PackFoodType(box(middle)), getFood_PackFoodType(target)) then
            high := middle-1;
            
      elsif lessthan(getFood_PackFoodType(box(middle)), getFood_PackFoodType(target))then
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
