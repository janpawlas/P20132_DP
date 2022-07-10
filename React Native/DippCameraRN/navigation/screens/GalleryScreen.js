import * as React from 'react';
import {View, Text, StyleSheet} from 'react-native';
import GridImageView from 'react-native-grid-image-viewer';
import { useGlobal } from 'reactn';

export default function GalleryScreen({navigation}){//galerie
    const [imgs, setImgs] = useGlobal('imgs');
    return (
    <View style={styles.background}>
      <GridImageView data={imgs} /> 
    </View>
  );
};

const styles = StyleSheet.create({
  background: {
    flex: 1,
  },
  headline_text: {
    color: 'white',
    fontSize: 30,
    fontWeight: 'bold',
    marginTop: 50,
    marginLeft: 20,
  },
  explore_text: {
    marginTop: 5,
    marginBottom: 10,
    color: 'white',
    marginLeft: 20,
    fontSize: 12,
    fontWeight: '600',
  },
});