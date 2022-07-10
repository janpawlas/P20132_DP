import React from 'react'
import { StyleSheet, Text, View, Image } from 'react-native';
import { Image as RNImage } from 'react-native-elements';

const styles = StyleSheet.create({
    container: {
        shadowColor: 'black',
        shadowOffset: { width: 0, height: 2 },
        shadowRadius: 6,
        shadowOpacity: 0.26,
        elevation: 8,
        backgroundColor: 'white',
        padding: 20,
        borderRadius: 10,
        marginVertical: 5,
        marginHorizontal: 10,
        flexDirection: 'row'
    },
    image: {
        width: 70,
        height: 70,
        borderRadius: 10
    },
    titleContainer: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center'
    },
    title: {
        flexWrap: 'wrap',
        marginHorizontal: 10,
    }
});

//vzor karty
const NewCard = ({ item }) => {
    return (
        <View style={styles.container}>
            <Image
                source={{uri: item.thumb_url}}
                style={styles.image}
            />
            <View style={styles.titleContainer}>
                <Text style={styles.title}>{item.name}</Text>
                <Text >{item.price}</Text>
            </View>

        </View>
    )
}

export default NewCard

