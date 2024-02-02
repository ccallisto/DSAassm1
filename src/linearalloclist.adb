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
      
      temp := last;
         while temp >= first and then msgFoodType < GetFoodType(list(temp)) loop 
            list(temp+1) := list(temp);
            temp := temp-1;
         end loop;
         if temp = last then
            list(last+1) := msg;
         elsif temp < first then
            list(first) := msg;
         else 
            list(temp+1) := msg;
         end if;
         last := last +1;
      end insert;
     
   procedure remove(msg: out message) is
      msgFoodType : Food_Type := GetFoodType(msg);
   begin
      index := get(msgFoodType);
         for i in index..last loop
            list(i +1) := list(i);
            last := last-1;
           end loop;
      end remove;
   
function get(targetFoodType : Food_Type) return slotindex is
   low : slotindex := lower_bound;
   high : slotindex := last - 1; 
   mid : slotindex;
   currentFoodType : Food_Type;
begin
   while low <= high loop
      mid := (low + high) / 2;

      currentFoodType := GetFoodType(list(mid));
      if currentFoodType < targetFoodType then
         low := mid + 1;
      elsif currentFoodType > targetFoodType then
         high := mid - 1;
      else
         return mid;
      end if;
   end loop;

   return slotindex'Last; 
end get;
   
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
