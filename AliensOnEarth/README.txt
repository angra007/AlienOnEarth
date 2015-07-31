About Software:
This is a application to register details of Aliens and export the details into a selected file format. The code is highly dynamic and can easily be extended . AlienOnEarth Class is responsible for all taking the input and validating it. ExportManager is responsible to initiate and call start export according to the input selected. ExportDataSuperClass is the super class for all the operations. Its role is to provide data for export. Each export file will implement a method -fileFormatterWithData: which will give the drawing logic of the format. 

System Requirements:
To run this application Xcode 6 or later is required

Method of Installation:
Run the application. For best view in the console please hide the variable view and utility panel

Extension for exporting format:
To extend this code just subclass from ExportDataSuperClass and implement -fileFormatterWithData:. No other code changes are required. This code checks at runtime which export types are available and proceed accordingly