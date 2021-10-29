import "./App.css";
import UserInput from "../src/components/LoginPage/UserInput";
import Login from "../src/components/LoginPage/Login";
// import { auth } from "../src/firebase";
// import Login from "./components/LoginPage/Login";
// import UserInput from "./components/LoginPage/UserInput";
import { BrowserRouter as Router, Route, useHistory } from "react-router-dom";
import SignupPage from "../src/components/SignupPage/SignupPage";

const App = () => {
  // const history = useHistory();
  // const [user, setUser] = useState("");
  // const [email, setEmail] = useState("");
  // const [password, setPassword] = useState("");
  // const [emailError, setEmailError] = useState(""); //for error-case(email)
  // const [passwordError, setPasswordError] = useState(""); //for error-case(password)
  // const [hasAccount, setHasAccount] = useState(false); //for switch in signin - login

  // const clearInputs = () => {
  //   setEmail("");
  //   setPassword("");
  // };

  // const clearErrors = () => {
  //   setEmailError("");
  //   setPasswordError("");
  // };

  // const handleLogin = () => {
  //   clearErrors();
  //   auth.signInWithEmailAndPassword(email, password).catch((err) => {
  //     // catching errors
  //     switch (err.code) {
  //       case "auth/invalid-email":
  //       case "auth/user-disabled":
  //       case "auth/user-not-found":
  //         setEmailError(err.message);
  //         break;
  //       case "auth/wrong-password":
  //         setPasswordError(err.message);
  //         break;
  //     }
  //   });
  // };

  // const handleSignup = () => {
  //   history.push("/SignupPage");
  // };

  // const handleLogOut = () => {
  //   auth.signOut();
  // };

  // const authListener = () => {
  //   auth.onAuthStateChanged((user) => {
  //     if (user) {
  //       clearInputs();
  //       setUser(user);
  //     } else {
  //       setUser("");
  //     }
  //   });
  // };

  // useEffect(() => {
  //   authListener();
  // }, []);

  return (
    <div className="app">
      <UserInput />
    </div>
  );
};

export default App;
