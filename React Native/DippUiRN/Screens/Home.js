import React, { useState } from 'react'
import {  Button, StyleSheet,  View, SafeAreaView, ScrollView, StatusBar  } from 'react-native';
import { Form, FormItem, Picker, Label } from 'react-native-form-component';
import DateTimePicker from '@react-native-community/datetimepicker';
import { Checkbox, RadioButton, Text, Switch } from 'react-native-paper';

export default function Home() {//logika ukládání dat formuláře
    const [picker, setPicker] = useState(1);
    const [number, setNumber] = useState();
    const [text, setText] = useState("");
    const [password, setPassword] = useState("");
    const [date, setDate] = useState(new Date());
    const [mode, setMode] = useState('date');
    const [show, setShow] = useState(false);
    const [isSwitchOn, setIsSwitchOn] = useState(false);
    const [checkedCheckbox, setCheckedCheckbox] = useState(false);
    const [value, setValue] = React.useState('first');

    const showMode = (currentMode) => {
        setShow(true);
        setMode(currentMode);
    };

    const showDatepicker = () => {
        showMode('date');
    };

    const showTimepicker = () => {
        showMode('time');
    };
    const onChange = (event, selectedDate) => {
        const currentDate = selectedDate || date;
        setShow(Platform.OS === 'ios');
        setDate(currentDate);
        console.log(currentDate)
    };

    const onToggleSwitch = () => setIsSwitchOn(!isSwitchOn);

    return (//formulářová pole
        <SafeAreaView   style={{ flex: 1, padding: 10 }}>
            <ScrollView>
                <Form onButtonPress={() => {
                    var startTime = performance.now()
                    console.log(`Form data are: ${text}, ${number}, ${password}, ${picker}, ${date}, ${date}, ${checkedCheckbox}, ${value}, ${isSwitchOn}, `)    
                    var endTime = performance.now()
                    var stopwatch = (endTime - startTime) / 1000
                    console.log(`Call to doSomething took ${stopwatch}`)
                    }}>
                    <FormItem
                        label="Text"
                        value={text}
                        onChangeText={(text) => setText(text)}
                    />
                    <FormItem
                        label="Number"
                        keyboardType="numeric"
                        value={number}
                        onChangeText={(number) => setNumber(number)}
                    />
                    <FormItem
                        label="Password"
                        secureTextEntry
                        value={password}
                        onChangeText={(password) => setPassword(password)}
                    />
                    <Picker
                        items={[
                        { label: 'Option 1', value: 1 },
                        { label: 'Option 2', value: 2 },
                        { label: 'Option 3', value: 3 },
                        ]}
                        label="Pick an option"  
                        selectedValue={picker}
                        onSelection={(item) => setPicker(item.value)}           
                    />
                    
                    <View>
                        <Label text="Date picker"  />
                        <Button onPress={showDatepicker} title="Show date picker!" />
                    </View>
                    <View>
                        <Label text="Time picker"  />
                        <Button onPress={showTimepicker} title="Show time picker!" />
                    </View>
                    <Label text="Switch"  />
                    <View style={{flexDirection: "row"}}>    
                        <Text style={{margin: 15}}>Is switch set?</Text>            
                        <Switch value={isSwitchOn} onValueChange={onToggleSwitch} />                
                    </View>

                        <Label text="Checkbox"  />
                    <View style={{flexDirection: "row"}}>
                        <Checkbox
                            status={checkedCheckbox ? 'checked' : 'unchecked'}
                            onPress={() => {
                                setCheckedCheckbox(!checkedCheckbox);
                            }}
                        />
                        <Text style={{margin: 8}}>Do you like React Native?</Text>
                    </View>
                    <Label text="Radio Button"  />
                    <RadioButton.Group onValueChange={newValue => setValue(newValue)} value={value}>
                        <View style={{flexDirection:"row"}}>
                            <RadioButton value="first" />
                            <Text style={{margin: 8}}>First</Text>
                        </View>
                        <View style={{flexDirection:"row"}}>
                            <RadioButton value="Second" />
                            <Text style={{margin: 8}}>Second</Text>
                        </View>
                        <View style={{flexDirection:"row"}}>
                            <RadioButton value="Third" />
                            <Text style={{margin: 8}}>Third</Text>
                        </View>
                        <View style={{flexDirection:"row"}}>
                            <RadioButton value="Fourth" />
                            <Text style={{margin: 8}}>Fourth</Text>
                        </View>
                    </RadioButton.Group>
                        {show && (
                                <DateTimePicker
                                    testID="dateTimePicker"
                                    value={date}
                                    mode={mode}
                                    display="default"
                                    onChange={onChange}
                                />
                        )}
                </Form>
            </ScrollView>
        </SafeAreaView>
    )
}