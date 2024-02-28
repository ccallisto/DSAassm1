with Food_DataStructures;
use Food_DataStructures;
with GateKeeperService;
use GateKeeperService;

package body linearalloclist is

        
   package IntIO is new Ada.Text_IO.Integer_IO(Integer);
   use IntIO;
   temp, index, last: slotindex:= 0;
   first, low : slotindex :=1;
   mid, high: slotindex;
   list: array(slotindex) of message;


   procedure insert(msg: in message) is
      msgFoodType : Food_Type := GetFoodType(msg);
      temp : slotindex;
   begin

      temp := last;
         while first < temp and then msgFoodType < GetFoodType(list(temp)) loop 
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
        --  printlist;

      end insert;
     
   procedure remove(msg: in out message; desiredFood: Food_Type) is

   found : Boolean := False;
   inmessg : message := msg;

begin
      if not isEmpty then
   high := last;
   while low <= high loop
      mid := (low + high) / 2;
      
      if GetFoodType(list(mid)) < desiredFood then    
         low := mid + 1;
      elsif GetFoodType(list(mid)) > desiredFood then
         high := mid - 1;
      else
         found := True;
            msg := list(mid);
         exit; 
      end if;
   end loop;
   
   if found then
      for i in mid..last  loop
         list(i) := list(i + 1);
      end loop;
            last := last - 1;
        --  printlist;

         else
         Put("sorry, no food packets of  ");PrintFoodType(Food_Type( desiredfood )); Put_Line(" are currently available");
         msg := list(last);
            last := last-1;
       --  printlist;

         end if;

  end if;
end remove;

      
   
   function isFull return Boolean is
      
   begin

      if last = Capacity then
         return True;
      else
         return False;
      end if;
      end isFull;
   
   function isEmpty return Boolean is
   begin
      if last < first then
      return True;
      else
      return False;
      end if;
      end isEmpty;
   
   procedure printlist is
            printFood : Food_Type;
   begin
      for i in first..last loop
         printFood := GetFoodType(list(i));
                  put ("[");
         PrintFoodType(printFood);
         put("]");
      end loop;
      new_line;
end printlist;

end linearalloclist;
