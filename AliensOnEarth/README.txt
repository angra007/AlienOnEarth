About Software:
This is a application to register details of Aliens and export the details into a selected file format. This
application is highly dynamic and can easily be extended. Users can either have registered themselves
earlier or they can start a new registration process. AlienRegistration.h/.m manages all the registration
related task and validate input. If the user has already registered AlienDetailsFetcher.h/.m class fetches
the details. In both cases, a registered user is allowed to export their data. ExportManager.h/.m class
manages all the export related tasks. This class looks into all the available export types and initialize
the export according to the user input. Exporter.h/.m is the super class for all the export type. This class
provides the data to export whereas all the export type will provide the logic to create file.

To extend this code just subclass from Exporter and implement -fileFormatterWithData:. No other code changes
are required. This application will check for all the available export type available at runtime and proceed
accordingly

System Requirements:
To run this application Xcode 6 or later is requiredMethod of

Installation:Run the application. For best view in the console please hide the variable view and utility
panelExtension for exporting format:


