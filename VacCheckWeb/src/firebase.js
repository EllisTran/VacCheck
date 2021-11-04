import firebase from "firebase/app";
import "firebase/firestore";
import "firebase/auth";
import "firebase/storage";

const firebaseConfig = {
  apiKey: "AIzaSyBp1KweTccbGHPLHDXQMkJhikD0j4dZA_4",
  authDomain: "vaccheck-6a24b.firebaseapp.com",
  projectId: "vaccheck-6a24b",
  storageBucket: "vaccheck-6a24b.appspot.com",
  messagingSenderId: "685620451959",
  appId: "1:685620451959:web:8b1946844a5c2dc1550472",
  measurementId: "G-BG18CF3S0E",
};

const app = firebase.initializeApp(firebaseConfig);
const auth = app.auth();
const db = firebase.firestore();
const storage = firebase.storage();
export { auth, db, storage };
