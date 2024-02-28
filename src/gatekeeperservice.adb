
with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Calendar;  use Ada.Calendar;
with linearalloclist;
package body GateKeeperService is
   
   package IntegerIO is new Ada.Text_IO.Integer_IO(Integer);  use IntegerIO;
    initCapacity: Natural; 
   task body GateKeeper is
   function GetFoodType(msg : Food_Pack) return Food_Type is
      begin 
      return getFood_PackFoodType(msg);
   end GetFoodType;
      function makeCapacity return Natural is
      begin
         put ("How much list space?   " );
           get(initCapacity);
         New_Line;
         return initCapacity;
      end makeCapacity;
   package FoodList is new linearalloclist(Food_Pack, GetFoodType, makeCapacity);
   use FoodList;

   

   rejected: Integer := 0;

   MgtDesiredFoodTypeToSell: Food_Type;

   Start_Time: Ada.Calendar.Time;
   End_Time:   Ada.Calendar.Time;
   begin
      
      delay 0.5;  
      Start_Time := Ada.Calendar.Clock;
      End_Time := Start_Time + 1.0 * 8.0 * 5.0; 
      
      while rejected < 5 and Ada.Calendar.Clock < End_Time loop  

         
         select
            accept acceptMessage(newFood: in Food_Pack) do
               if not(FoodList.isFull) then
                  FoodList.insert(newFood);
                  put("GateKeeper insert accepted     ");
                  PrintFood_Pack(newFood); new_line;
                  FoodList.printlist;
               else
                  rejected := rejected + 1;
                  put(" Rejected by GateKeeper: "); new_line;
                  PrintFood_Pack( newFood ); new_line;
                  put(" Rejected = "); put(rejected);
                  put(". Sent to another distribution facility!"); new_line(3);
               end if;
            end acceptMessage;
         or
            accept retrieveMessage( newFood: out Food_Pack; availableForShipment: out Boolean) do
              availableForShipment := False;

                 availableForShipment := True;
                 MgtDesiredFoodTypeToSell := RandomFoodType;
                 FoodList.remove(newFood, MgtDesiredFoodTypeToSell);

                 
                 put("Mgt Desired Food Type To Sell is: ");
                 PrintFoodType( MgtDesiredFoodTypeToSell );
                 put(" Actual type sold is: ");  PrintFood_PackType( newFood ); new_line;
                 PrintFood_PackShipment( newFood );
                 put("Food pack removed by GateKeeper for shipment."); new_line(2);
                 FoodList.printlist;
            end retrieveMessage;
         end select;

         delay 1.1; 
      end loop;

      -- print time in service, statistics such as number food pacekets of meat and non-meat products processed.
      new_line(2);  put("Hours of operation prior to closing: ");
      Ada.Text_IO.Put_Line(Duration'Image(Ada.Calendar.Clock - Start_Time)); new_line(2);

   end GateKeeper;
end GateKeeperService;
