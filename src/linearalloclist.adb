package body linearalloclist is
   
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
         while temp >= first and list[temp] > msg loop --fill in dot operator for generic type here
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
      begin
         
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
