with Food_DataStructures;
use Food_DataStructures;


package body linearalloclist is
    type message is record
        food_type: Food_Type;
        
    end record;
   package IntIO is new Ada.Text_IO.Integer_IO(Integer);
    use IntIO;

   capacity: Natural := 21;
   
   subtype slotindex is natural range 0..(capacity-1);
   first, last, temp: slotindex := 0;
   list: array(slotindex) of message;
   max : natural := capacity -1;
   
      
   procedure insert(msg: in message) is
      begin
      
      temp := last;
      if not (isFull) then
         while temp >= first and list[temp].food_type > msg.food_type loop --fill in dot operator for generic type here
            list[temp+1] = list[temp];
            temp := temp-1;
         end loop;
         if temp = last then
            list[last+1] := msg;
         elsif temp < first then
            list[first] := msg;
         else 
            list[temp+1] = msg;
         end if;
         last = last +1;
         
      end insert;
     
   procedure remove(msg: in message) is
      index := get(msg);
      begin
         for i range msg..last loop
            list[i +1] := list[i];
            last := last-1;
           end loop;
      end remove;
   
   function get return Integer is
         lower_bound := first;
         upper_bound := last;
      begin
         while lower_bound < upper_bound loop
            index := (lower_bound + upper_bound)/2
            if msg.food_type < list[index].food_type then
               upper_bound := index-1;
            elsif msg.food_type > list[index]
               lower_bound := index + 1;
            else
            return index;
            exit;
            end if;
         end loop;
              
      return -1;
      end get;
   
   function isFull return Boolean is
      begin
      if last = max;
         return True;
      else
         return False;
      end if;
      end isFull;
   
   function isEmpty return Boolean is
      begin
      if last = first;
      return True;
      else
      return False;
      end if;
      end isEmpty;
   
end linearalloclist;
