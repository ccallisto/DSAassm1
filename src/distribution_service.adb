with Food_DataStructures; use Food_DataStructures;
with GateKeeperService;  use GateKeeperService;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random, Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO, Ada.Calendar;
use Ada.Numerics.Float_Random, Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;

package body Distribution_Service is

  task body Product_Generator is
    RandFloatGenerator    : Generator; -- Has own generator default seed.
    randFloat : Float;

    newFood: Food_Pack;

    nextArrivalDelay: float;
  begin
    -- Initialize the random number generator without specifying a seed
    Reset(RandFloatGenerator);

    -- Start the simulation with an arriving vessel.
    loop
        --put("In Product_Generator of DistributionServices."); new_line(2);

        setFood_PackFoodType( newFood, Food_DataStructures.RandomFoodType );
        if getFood_PackFoodType(newFood) in GrainVegetable then
           setFood_PackShipment( newFood, 'B');  -- 'B' for basic grain or vegetable.
        else
           setFood_PackShipment( newFood, 'M');  -- 'M' for meat. 
        end if;

        if getFood_PackFoodType( newFood) in GrainVegetable then
           delay( PrepareGrainVegetableFood_PackforSales );
        else
           delay( PrepareMeatFood_PackforSales );
        end if;

        PrintFood_PackShipment(newFood);  put(" delivered. "); new_line(2);

        GateKeeper.acceptMessage( newFood ); --moved into gatekeeper

        -- Schedule arrival of next star ship exponentially distributed over 1.534 seconds (hours).
        nextArrivalDelay := Next_Exponential;

        nextArrivalDelay := nextArrivalDelay * 1.534;  -- Food cargo vessels arrive every 1.534 hours
        Put("Next grain shipment arrives "); put(nextArrivalDelay); Put(" Time units!"); -- exponentially distributed.
        new_line(2);

        -- Schedule the random arrival of the next cargo ship exponentially distributed (Poisson Distribution).
        -- Sleep till next ship arrives by casting float to duration.
        delay Standard.Duration( nextArrivalDelay );

    end loop;

  end Product_Generator;

end Distribution_Service;

