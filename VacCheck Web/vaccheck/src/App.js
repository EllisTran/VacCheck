import { onSnapshot, collection, doc } from "firebase/firestore";
import { useEffect, useState } from "react";
import SignupPage from "./components/SignupPage/SignupPage";
import db from "./firebase";

function App() {
  const [users, setUsers] = useState([]);

  console.log(users);
  
  useEffect(
    () =>
      onSnapshot(collection(db, "users"), (snapshot) => {
        setUsers(snapshot.docs.map((doc) => ({...doc.data(), id: doc.id})));
      }),
    []
  );

  return <SignupPage></SignupPage>;
}

export default App;
