The Boxing Kata
=================

####Expected Time to Complete: 2 - 3 hours

Everyone who has dental insurance through Beam receives perks in the form of electric toothbrushes, replacement brush heads, and paste kits (toothpaste and floss). These perks are provided at the start of an insurance contract and then semi-frequently throughout the life of the contract. Each family member gets to choose a toothbrush color at enrollment, and will receive replacement toothbrush heads of the same color.

This kata involves building the brains of a boxing system which will determine how the perks are boxed up and shipped. Given a family's brush color preferences, the system will generate a description of how the boxes should be filled. A shipping manager must be able to load data for a family, create starter and refill boxes, and perform other operations in real-time. The focus of this kata should be building a library for the system rather than a UI.

Instructions
------------
Please read through the user stories listed in the accompanying [STORIES.md](STORIES.md) file and implement the functionality to complete them according to their requirements. We've provided a structure for you, as well as a command line interface. Feel free to deviate from the existing structure as you please. We also ask that you commit your work to git frequently as you go.

### Evaluation criteria
As there are often trade-offs when crafting a solution, the following is the priority of what we are considering when reviewing your kata:

- **Functionality:** The solution should fulfill the requirements and work correctly. Please feel free to reach out if you have questions about the provided user stories.
- **Testing:** Beam firmly believes in testing as a practice and as such we ask that you add tests. We prefer to see code that has good test coverage.
- **Structure:** Well-factored code is easier to reason about and maintain. We prefer to see good separation of concerns in the architecture.
- **Idiomatic code:** Along similar lines, code that adopts the best practices, idiom and conventions of the language/framework helps with readability and maintainability.

### Additional sections to include
These sections will help us understand your thought process and workflow while we review your solution. Feel free to add these sections to this README or in a separate file. 

- **Technical decision making:** Please add a section explaining the technical decision making involved in designing your solution. What options were you considering at various levels (eg. tech stack choice, libraries, and design, as applicable) and what were the trade-offs in choosing one option over another?
- **Instructions on running your code:** As you decide on the tools to build the solution, please add a section letting us know how to run your code and tests if it is different from the provided [setup](#setup).

Setup
-----

Install dependencies with the following command:

```bash
$ bundle install
```

The `rspec` testing framework has been installed for you, and tests can be run with the following command:

```bash
$ bin/rspec
```

If you would prefer to not use `rspec` for your tests, or have included non-rspec ones, please add instructions on how to run them. We'd love to hear your thought process behind that decision as well! (see [additional sections](#additional-sections-to-include))

An entry point has been provided for running the Kata:

```bash
$ ruby ./bin/boxing-kata spec/fixtures/family_preferences.csv
```

Submitting your work to Beam
--------------------

For ease of evaluation, we require that this kata is completed using the 2.7.0 version of ruby. This has already been set in the `.ruby-version` file and, for reinforcement, in the gem specifications as well. Please make sure to complete your kata using this version. 

Once you're happy with your submission ([evaluation criteria](#evaluation-criteria), [additional sections](#additional-sections-to-include)), you can send it back in one of two formats, as a git bundle or as a zip file.

To create the git bundle simply execute the following from the root of the kata:

```bash
$ git bundle create boxing-kata.bundle <YOUR BRANCH NAME HERE>
```

This will create a `.bundle` file which contains the entire git repository in binary form, so you can easily send it as an attachment.  Alternately, you could send the project as a zip file.

To ensure that our review of your kata remains as unbiased as possible, your submission will be anonymized before it is reviewed. To help us with this process, **please double check that any personally identifiable information, such as your name or email address, is removed from your code, readme or any commit messages**. Your author and committer information will be scrubbed by our anonymizing process.


Example Input File
------------------
The input file is a CSV file which contains the following fields:

```
id,name,brush_color,primary_insured_id,contract_effective_date
2,Anakin,blue,,2018-01-01
3,Padme,pink,2,,
4,Luke,blue,2,,
5,Leia,green,2,,
6,Ben,green,2,,
```

Currently, we only support one family per configuration file.

# Ruby-Boxing-kata