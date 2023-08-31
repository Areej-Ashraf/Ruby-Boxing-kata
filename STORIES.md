User Stories
--------------

**Importing family preferences**

_As a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to view family member brush preferences_<br>

To begin the boxing process the shipping manager must import family data.  When the system receives the input file, then the brush color counts will be displayed in the format below.
The CsvParser class skeleton provided has methods you can use to get started.

```
BRUSH PREFERENCES
blue: 2
green: 2
pink: 1
```
**Starter boxes**

_As a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to fill starter boxes_<br>

Now that member data has been imported, the shipping manager can begin filling boxes. Each family member will receive one brush and one replacement head. Both the brush and the replacement head must be in the family member's preferred color. A starter box can contain a maximum of 2 brushes and 2 replacement heads in any combination of colors.
The Boxer class has some skeleton methods you can use to get started, and operates on the output of the CsvParser class.

When the shipping manager presses the starter boxes button, then a number of boxes are output.  Using the brush preferences example above, box output will be generated in the following format:

```
STARTER BOX
2 blue brushes
2 blue replacement heads

STARTER BOX
2 green brushes
2 green replacement heads

STARTER BOX
1 pink brush
1 pink replacement head
```

If no family preferences have been entered then the message `NO STARTER BOXES GENERATED` should be displayed.

We've provided a skeleton BoxPrinter class that you can use to get started printing the output for a set of boxes.

**Refills**

_As a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to fill refill boxes_<br>

A family should receive refill boxes with a replacement brush head in each member's preferred color. A refill box can contain a maximum of 4 replacement heads. When the shipping manager presses the refill boxes button, then a number of refill boxes are output.  Using the brush preferences example above, box output will be generated in the following format:

```
REFILL BOX
2 blue replacement heads
2 green replacement heads

REFILL BOX
1 pink replacement head
```

If no starter boxes have been generated, then the message `PLEASE GENERATE STARTER BOXES FIRST` should be displayed.

The Boxer class has some skeleton methods you can use to get started, and operates on the output of the CsvParser class.
We've provided a skeleton BoxPrinter class that you can use to get started printing the output for a set of refill boxes.

**Scheduling**

_As a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to schedule boxes for shipping_<br>

Members should receive perks throughout the length of their contract (1 year).  The shipping date is based on the contract effective date of the primary insured family member.  Starter boxes should be scheduled on the contract effective date.  Refills are scheduled every 90 days after that for the remainder of the year. When boxes are generated then each box should have a line appended with its scheduled ship date(s).

Example for a starter box:
```
STARTER BOX
2 green brushes
2 green replacement head
Schedule: 2022-01-01
```

Example for a refill box:
```
REFILL BOX
1 pink replacement head
Schedule: 2022-04-01, 2022-06-30, 2022-09-28, 2022-12-27
```

**Mail Class**

_As a Beam shipping manager_<br>
_In order to save money on shipping_<br>
_I want to determine mail class_<br>

In order to manage shipping costs and to deliver perks quickly we want to determine the mail class of boxes. Mail class is based on the weight of the box. Boxes that weigh 16oz or more have a class of "priority".  Boxes that weigh less than 16oz have a mail class of "first". Weight is calculated as such: 1 brush weighs 9oz, and 1 replacement head weighs 1oz. When boxes are generated, then each box should have a line appended with its mail class.

Example for a starter box:
```
STARTER BOX
2 green brushes
2 green replacement head
Schedule: 2022-01-01
Mail class: priority
```

Example for a refill box:
```
REFILL BOX
1 pink replacement head
Schedule: 2022-04-01, 2022-06-30, 2022-09-28, 2022-12-27
Mail class: first
```

**Paste Kits**

_As a Beam shipping manager_<br>
_In order to ship paste kits_<br>
_I want to add paste kits to the boxes_<br>

For each brush or replacement head that is shipped a paste kit is also shipped which contains toothpaste and floss. A paste kit weighs 7.6 oz which will impact on the mail class choice.

Example for a starter box:
```
STARTER BOX
1 pink brush
1 pink replacement head
1 paste kit
Schedule: 2022-01-01
Mail class: priority
```

Example for a refill box:
```
REFILL BOX
1 pink replacement head
1 paste kit
Schedule: 2022-04-01, 2022-06-30, 2022-09-28, 2022-12-27
Mail class: first
```
**