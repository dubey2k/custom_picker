# custom_dropdown

A Flutter Package that provides you an beautified alternative of Dropdown widget.
It is highly Customizable in terms of size, color, style, etc.


## Import

``` yaml
dependencies:
  custom_picker: <latest_version>
```

## Usage

You can use multiple text beautification options with detected text formats.

```dart
CustomPicker(
  // deciding list whether to show loop over popup items
  optionLoop: [false, false],
  // give popup height
  popupHeight: 200,
  // where to show popupmenu
  below: false,
  // give where to place popup vertically
  verticalOffset: 10,
  // hanfle all changes here
  handleChange: (list) {
    print(list);
  },
  // to include yes no dialog or not
  yesNo: true,
  //give color to popup selected option
  popUpSelColor: Colors.black.withAlpha(150),
  // customize text style for each popUp list
  popUpTextStyle: const [
    TextStyle(color: Colors.white, fontSize: 20),
    TextStyle(color: Colors.white, fontSize: 20),
  ],
  // customize text style for each list
  widTextStyle: const [
    TextStyle(color: Colors.black, fontSize: 18),
    TextStyle(color: Colors.black, fontSize: 18),
  ],
  // customize divider color
  divColor: Colors.black,
  //give a decoration to your popupmenu
  popUpDecoration: BoxDecoration(
      color: Colors.black.withAlpha(100),
      borderRadius: BorderRadius.circular(10)),
  // decorate your picker widget
  widDecoration: BoxDecoration(
    border: Border.all(width: 2, color: Colors.black),
    borderRadius: BorderRadius.circular(10),
  ),
  // input all list you want to display in popupmenu
  list: const [
    ['1', '2', '3', '4', '5', '6'],
    ['one', 'two', 'three']
  ],
  // control flex property of picker children
  wtList: [3, 1],
  // callback that'll be call when option of YesNo dialog is clicked
  onChanged: (List<int> value) {
    print(value);
  },
  //give initial selected item indicies
  selected: const [0, 1],
)
       
```


## Parameters


|   parameter        |      description                                                                                     |  default                                 |
| ------------------ | ---------------------------------------------------------------------------------------------------- | ---------------------------------------- |
|   popupHeight      |     The height of the popup                                                                          |  400                                     |
|   optionLoop       |     List<bool> which child to loop over wheel                                                        |  true for all children                   |
|   below            |     show popup widget below the [CustomPicker]                                                       |  Color(0xFF424242)                       |
|   popUpDecoration  |     The FontWeight of UnDetected Text                                                                |  radius : 10, border: Color(0xFF424242)  |
|   verticalOffset   |     vertical position of popup widget                                                                |  TextAlign.start                         |
|   selected         |     initially selected list                                                                          |  required                                |
|   yesNo            |     whether to show YesNo dialog                                                                     |  false                                   |
|   popUpTextStyle   |     add TextStyle of popup children                                                                  |  TextStyle(fontSize: 17)                 |
|   widTextStyle     |     add TextStyles of Picker Children                                                                |  TextStyle()                             |
|   onChanged        |     Whenever the current date is changed. If this is null, the picker is considered disabled         |  required                                |
|   handleChange     |     any change in any child will call this method                                                    |  void                                    |
|   popUpMargin      |     Margin for PopUp Widget (if it is zero, pop up widget will be visible at the center of picker)   |  hor = 20 , ver =20                      |
|   onCancel         |     Whenever the user cancels when changing the date.                                                |  void                                    |
|   list             |     List<List<dynamic>> List of Lists of Options to be displayed on pop up widget                    |  required                                |
|   wtList           |     List<int> flex propertry of visible widget items                                                 |  equal for each child                    |
|   contentPadding   |     The padding of the picker widget                                                                 |  zero                                    |
|   widDecoration    |     BoxDecoration for visible widget                                                                 |  BoxDecoration()                         |
|   childDecoration  |     BoxDecoration for visible widget's child                                                         |  default TextStyle                       |
|   widHeight        |     height for visible widget                                                                        |  40                                      |
|   divColor         |     Divider Color for visible Widget                                                                 |  Color(0xFF424242)                       |
|   popUpSelColor    |     PopUp Selected Item Color                                                                        |  Colors.white                            |
|   optionLoop       |     List<bool> which child to loop over wheel                                                        |  true for each child                     |
