defmodule ParkingLot do
  @moduledoc """
  Documentation for CarParkingLot.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ParkingLot.main()
      :world

  """
  


  def main() do
    # parsed =  OptionParser.parse(["--file", args], strict: [create: :integer]) use this for the file parsing
    slots = []
    parse(slots)
  end

  

def park(slot, registration_number, color) do
    
    list = Enum.sort(slot)
    if length(slot) >0 do
    empty_slots = Enum.filter(slot, fn(event) -> event[:status] == 0 end)
    if length(empty_slots) > 0 do

    if length(empty_slots) > 1 do
    sort_val = empty_slots |> Enum.sort(& &1["slot"] <= &2["slot"])
    allocated_slot = Enum.at(sort_val, 0) 
    car_park_details = %{reg_num: registration_number, color: color, slot: allocated_slot[:slot], status: 1}
    car_parked = List.replace_at(list, allocated_slot[:slot] - 1, car_park_details)
    IO.puts "car parked"
    car_parked
    else

    allocated_slot = Enum.at(empty_slots, 0) 
    car_park_details = %{reg_num: registration_number, color: color, slot: allocated_slot[:slot], status: 1}
    car_parked = List.replace_at(list, allocated_slot[:slot] - 1, car_park_details)
    IO.puts "car parked"
    car_parked
    
    end
    else
    IO.puts "slot full"
    slot
    end

    else
     IO.puts "slot free"
     slot
    end
   end

   
 def freeup(slots, value) do
   {value, ""} = Integer.parse(value)
    original_slot = slots
    if length(slots) > 0 do        
      car_park_details = %{reg_num: "xx", color: "xx", rent: 1000, slot: value, status: 0}
        free_space = List.replace_at(slots, value - 1, car_park_details)
         original_slot = free_space
        else
           IO.puts "please create the slot"
        end

        original_slot
       
  end

  def status(list) do

    if length(list) > 0 do 
      list = Enum.sort(list)
      assigned_slots = Enum.filter(list, fn(event) -> event[:status] == 1 end)
      if length(assigned_slots) >= 1 do
        IO. puts("slot"  <> "  reg_num" <> "  color")
        Enum.each(assigned_slots, fn x ->  IO.puts("#{x.slot}       #{x.reg_num}   #{x.color}")end)
      else
        IO.puts("")
        list
      end
    else
      IO.puts("No cars")
      ParkingLot.main()
    end
    list
  end


  def registration_numbers_for_cars_with_colour(list, input) do
   
    if length(list) > 0 do 
      list = Enum.sort(list)
      assigned_slots = Enum.filter(list, fn(event) -> event[:color] == input end)
        if length(assigned_slots) >= 1 do
          Enum.each(assigned_slots, fn x -> IO.puts ("#{x.reg_num}") end)
      else
        IO.puts("No cars")
       end
    else
       IO.puts "please create the slot"
    end
    list

  end
    

  def createslot(slot,value) do
    {num, ""} = Integer.parse(value)
		list = []
		slots = Enum.map(1..num, fn (x) -> %{reg_num: 200, color: 1000, status: 0, slot: x } end)
    IO.puts("Your car has been parked successfully \n")
    slots
  end


  def get_input(content) do
    IO.gets(content) |> String.replace("\n", "")
  end


  def parse(slots) do
    command_get =  IO.gets("Input: \n") |> String.replace("\n", "")
    commands =  command_get  |> String.split
    parse(command_get, slots)
  end

  def parse(command, slots) do
   command_get =  command
   commands =  command_get  |> String.split

  cond do
      length(commands) == 1 ->
        [command] = commands
        cond do
          command == "status" ->
            slots =  status(slots)
            parse(slots)
          true ->
            IO.puts("Invalid Input")
            ParkingLot.main()
        end

       length(commands) == 2 ->
        [command, value] = commands
        cond do
          command == "create_parking_lot" ->
        slots = createslot(slots,value)
        parse(slots)
        command == "leave" ->
            slots = freeup(slots, value)
            parse(slots)
          command == "registration_numbers_for_cars_with_colour" ->
            slots = registration_numbers_for_cars_with_colour(slots, value)
            parse(slots)
          true ->
            IO.puts("Invalid Input")
            ParkingLot.main()
        end

         length(commands) == 3 ->
        [command, value1, value2] = commands
        cond do
          command == "park" ->
            slots = park(slots, value1, value2)
            parse(slots)
          true ->
            IO.puts("Invalid Input")
            ParkingLot.main()
        end

    true ->
        IO.puts("Invalid")
        ParkingLot.main()
    end

  end

end
