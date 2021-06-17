# custom_dropdown

A Flutter Package that provides you an beautified alternative of Dropdown widget.
It is highly Customizable in terms of size, color, style, etc.


## Import

``` yaml
dependencies:
  custom_picker: <latest_version>
```

## Code to use

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
    //give color to popup selected option
    popUpSelColor: Colors.white,
    //give a decoration to your popupmenu
    popUpDecoration: BoxDecoration(
        color: Colors.amber.withAlpha(50),
        borderRadius: BorderRadius.circular(10)),
    // decorate your picker widget
    widDecoration:
        BoxDecoration(border: Border.all(width: 2, color: Colors.grey)),
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
