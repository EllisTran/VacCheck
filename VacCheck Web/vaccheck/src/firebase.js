// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries
import {  } from "firebase/auth"
import {  } from "firebase/firestore"

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyBp1KweTccbGHPLHDXQMkJhikD0j4dZA_4",
  authDomain: "vaccheck-6a24b.firebaseapp.com",
  projectId: "vaccheck-6a24b",
  storageBucket: "vaccheck-6a24b.appspot.com",
  messagingSenderId: "685620451959",
  appId: "1:685620451959:web:8b1946844a5c2dc1550472",
  measurementId: "G-BG18CF3S0E"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);