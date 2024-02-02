with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Calendar;  use Ada.Calendar;
with linearalloclist;
package body GateKeeperService is
   
   package IntegerIO is new Ada.Text_IO.Integer_IO(Integer);  use IntegerIO;
  
            
   task body GateKeeper is
      -- define getfoodtype and pass within the function below once passed i can use ame as one inlinearlist
   function GetFoodType(msg : Food_Pack) return Food_Type is
      begin 
      return getFood_PackFoodType(msg);
   end GetFoodType;
      --return getfoodtype(msg)
      
      --instantiate package linearalloclist is new 
   package LinearAllocListInstance is new linearalloclist(Food_Pack, GetFoodType);
   use LinearAllocListInstance;
      --  package linearalloclist is new linearalloclist(Food_Pack, GetFoodType); -- **  specify size for storage space.
      --  use linearalloclist;
                                                                            

      rejected: Integer := 0;
      -- Declare food packet counters here.

      MgtDesiredFoodTypeToSell: Food_Type;

      Start_Time: Ada.Calendar.Time;
      End_Time:   Ada.Calendar.Time;

   begin
   

      delay 0.5;  -- allow 1/2 hour to initialize facility.
      Start_Time := Ada.Calendar.Clock;
      End_Time := Start_Time + 1.0 * 8.0 * 5.0; -- 1.0 sec./hour * 8 hours/days * 5 days

      -- Termiate after lossing 5 customers or time to close has arrived.
      while rejected < 5 and Ada.Calendar.Clock < End_Time loop  -- Termiate after lossing 5 customers

         -- In Ada, a "select" statement with multiple "or" options must uniformly
         -- process (randomly) the "accept" statements.  This prevents any single
         -- "accept" from starving the others from service.
         --
         -- Rules for "Select": 
         -- 1) If no task are waiting for service, the task sleeps. 
         -- 2) If only one of the "accept" entries has a task waiting that task is served.
         -- 3) If sleeping and a task or tasks arrive simultaneously, awake a service the 
         --    the first arrival.
         -- 4) If multiple "accepts" have task waiting, service them in random order
         --    to prevent starvation.
         --

         select
            -- new arrivals of food
            accept insert(newFood: in Food_Pack) do
               if not(LinearAllocListInstance.isFull) then
                  LinearAllocListInstance.insert(newFood);
                  put("GateKeeper insert accepted ");
                  PrintFood_Pack( newFood ); new_line;
               else
                  rejected := rejected + 1;
                  put(" Rejected by GateKeeper: "); new_line;
                  PrintFood_Pack( newFood ); new_line;
                  put(" Rejected = "); put(rejected);
                  put(". Sent to another distribution facility!"); new_line(3);
               end if;
            end insert;
         or
            -- Accept request for distribution from sales
            accept remove( newFood: out Food_Pack; availableForShipment: out Boolean) do
              availableForShipment := False;

              if not(LinearAllocListInstance.isEmpty) then
                 availableForShipment := True;

                 LinearAllocListInstance.remove(newFood);

                 MgtDesiredFoodTypeToSell := RandomFoodType;
                 put("Mgt Desired Food Type To Sell is: ");
                 PrintFoodType( MgtDesiredFoodTypeToSell );
                 put("Actual type sold is: ");  PrintFood_PackType( newFood ); new_line;
                 --PrintFood_PackShipment( newFood );
                 put("Food pack removed by GateKeeper for shipment."); new_line(2);
              end if;
            end remove;
         end select;

         delay 1.1; -- Complete overhead due to accepting or rejecting a request prior to new iteration.
      end loop;

      -- print time in service, statistics such as number food pacekets of meat and non-meat products processed.
      new_line(2);  put("Hours of operation prior to closing: ");
      Ada.Text_IO.Put_Line(Duration'Image(Ada.Calendar.Clock - Start_Time)); new_line(2);

   end GateKeeper;
end GateKeeperService;
