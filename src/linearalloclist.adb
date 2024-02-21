with Food_DataStructures;
use Food_DataStructures;
with GateKeeperService;
use GateKeeperService;

package body linearalloclist is

        
   package IntIO is new Ada.Text_IO.Integer_IO(Integer);
   use IntIO;
   first, last, temp, index: slotindex := 0;
   list: array(slotindex) of message;
   max : natural;

   useCapacity : Natural;
   procedure insert(msg: in message) is
      msgFoodType : Food_Type := GetFoodType(msg);
      temp : slotindex;
   begin
      useCapacity := GetOperationalCapacity;
      max := useCapacity-1;
      Put("insert procedure running");
      temp := last;
         while first < temp and then msgFoodType < GetFoodType(list(temp)) loop 
            list(temp+1) := list(temp);
         temp := temp-1;
         end loop;
         if temp = last then
         list(last+1) := msg;
         --  Put_Line("     inserted in last position");
         elsif temp < first then
         list(first) := msg;
         --  Put_Line("     inserted in first position");
         else 
         list(temp+1) := msg;
         --  Put_Line("     inserted in middle position");
         end if;
         last := last +1;
      end insert;
     
   procedure remove(msg: in out message; desiredFood: Food_Type) is
   low: slotindex := 0;
   high: slotindex := GetOperationalCapacity-1;
   mid : slotindex;
   found : Boolean := False;
   inmessg : message := msg;

begin
   Put_Line("Starting removal process...");
   --  Put("List state before removal: ");
   -- Assuming you have a way to print the list or relevant details.
   -- This would depend on your implementation.
   
   --  Put_Line("Running binary search to find the item...");
   while low <= high loop
      mid := (low + high) / 2;
      --  Put("Checking position "); Put(Integer(mid)); Put_Line("...");
      
      if GetFoodType(list(mid)) < desiredFood then    
         low := mid + 1;
      elsif GetFoodType(list(mid)) > desiredFood then
         high := mid - 1;
      else
         found := True;
            Put_Line("Item found during binary search.");
            msg := list(mid);
         exit; -- Found the item, exit the loop
      end if;
   end loop;
   
   if found then
      -- Item found, proceed to remove it by shifting elements
      Put_Line("Item found, removing...");
      for i in mid..last - 1 loop
         list(i) := list(i + 1);
      end loop;
      last := last - 1; -- Update the last index since an item is removed
      Put_Line("Item removed successfully.");
   else
      -- Item not found, handle according to your specific requirements
         Put("sorry, no food packets of  ");PrintFoodType(Food_Type( desiredfood )); Put_Line(" are currently available");
         msg := list(last);
   end if;
   
   --  Put("List state after removal: ");
   -- Assuming again you have a way to print the list or relevant details.
end remove;

      
   
   function isFull return Boolean is
      
   begin
      max := GetOperationalCapacity;
      if last = max then
         return True;
      else
         return False;
      end if;
      end isFull;
   
   function isEmpty return Boolean is
   begin
      if last = first then
      return True;
      else
      return False;
      end if;
      end isEmpty;
   
       function GetOperationalCapacity return Natural is
   begin
      return OperationalCapacity;
   end GetOperationalCapacity;

   procedure SetOperationalCapacity(NewCapacity: in Natural) is
   begin
      if NewCapacity <= Capacity then
         OperationalCapacity := NewCapacity;
      else
         raise Constraint_Error;
      end if;
   end SetOperationalCapacity;
end linearalloclist;
