with Food_DataStructures;
use Food_DataStructures;
with GateKeeperService;
use GateKeeperService;

package body linearalloclist is

        
   package IntIO is new Ada.Text_IO.Integer_IO(Integer);
   use IntIO;
   first, last, temp, index: slotindex := 0;
   list: array(slotindex) of message;
   max : natural := capacity -1;
   lower_bound :slotindex := first;
   upper_bound :slotindex := last;

   procedure insert(msg: in message) is
      msgFoodType : Food_Type := GetFoodType(msg);
      temp : slotindex;
   begin
      Put("insert procedure running");
      temp := last;
         while first < temp and then msgFoodType < GetFoodType(list(temp)) loop 
            list(temp+1) := list(temp);
         temp := temp-1;
         end loop;
         if temp = last then
         list(last+1) := msg;
         Put_Line("     inserted in last position");
         elsif temp < first then
         list(first) := msg;
         Put_Line("     inserted in first position");
         else 
         list(temp+1) := msg;
         Put_Line("     inserted in middle position");
         end if;
         last := last +1;
      end insert;
     
   procedure remove(msg: in out message) is
      low: slotindex := lower_bound;
      high: slotindex := last-1;
      mid : slotindex;
      found : Boolean := False;
      inmessg : message := msg;
   begin
      while low <= high loop
         mid := ((low+high)/2);
      if GetFoodType(list(mid)) < GetFoodType(inmessg) then    
            low := mid+1;
      elsif GetFoodType(list(mid)) > GetFoodType(inmessg) then
           high := mid-1;
      else
           found := true;
         end if;
      end loop;
      
      if found then 
         msg := list(mid);
         for i in mid..last -2 loop
            list(i) := list(i+1);
         end loop;
         last := last-1;
      end if;
   end remove;   
      
   
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
      if last = first then
      return True;
      else
      return False;
      end if;
      end isEmpty;
   
end linearalloclist;
