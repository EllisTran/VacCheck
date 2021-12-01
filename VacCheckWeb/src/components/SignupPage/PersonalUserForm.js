import { useState } from "react";
import '../styling/SignupPage.css';
const PersonalUserForm = (props) => {
  const [enteredName, setEnteredName] = useState("");
  const [enteredDateOfBirth, setEnteredDateOfBirth] = useState("");
  const [enteredIdentityNumber, setEnteredIdentityNumber] = useState("");
  const [enteredEmailAddress, setEnteredEmailAddress] = useState("");
  const [enteredPassword, setEnteredPassword] = useState("");
  const [
    enteredNumberOfVaccinations,
    setEnteredNumberOfVaccinations,
  ] = useState("");

  const nameChangeHandler = (event) => {
    setEnteredName(event.target.value);
  };

  const dateOfBirthChangeHandler = (event) => {
    setEnteredDateOfBirth(event.target.value);
  };

  const identityNumberChangeHandler = (event) => {
    setEnteredIdentityNumber(event.target.value);
  };

  const enteredEmailAddressChangeHandler = (event) => {
    setEnteredEmailAddress(event.target.value);
  };

  const enteredPasswordChangeHandler = (event) => {
    setEnteredPassword(event.target.value);
  };

  const enteredNumberOfVaccinationsChangeHandler = (event) => {
    setEnteredNumberOfVaccinations(event.target.value);
  };

  const clearAccountInfo = () => {
    setEnteredName("");
    setEnteredDateOfBirth("");
    setEnteredEmailAddress("");
    setEnteredPassword("");
  };

  const submitHandler = (event) => {
    event.preventDefault();

    const accountInfo = {
      name: enteredName,
      dateOfBirth: new Date(enteredDateOfBirth),
      email: enteredEmailAddress,
      numVac: 0,
      password: enteredPassword,
      imageUrl: "https://firebasestorage.googleapis.com/v0/b/vaccheck-6a24b.appspot.com/o/avatar_115.jpg?alt=media&token=75c1e503-8269-4e17-9e5f-4c1ac99e5801",
    };
    console.log(accountInfo);
    clearAccountInfo();
    props.onSignup(accountInfo);
  };

  return (
    <form className="l" onSubmit={submitHandler}>
      <div className="">
        <div className="labelMargin">
          <label className="labels">Full Name</label>
          <span style={{ padding: "5%"}}></span>
          <label className="labels rightColumnLabel">Date of Birth</label>
        </div>
        <div className="">
          <input className="textBox" type="text" value={enteredName} onChange={nameChangeHandler} />
          <span style={{ padding: "5%"}}></span>
          <input
            className="textBox rightColumnTextBox"
            type="date"
            min="1900-1-1"
            max="2021-12-31"
            value={enteredDateOfBirth}
            onChange={dateOfBirthChangeHandler}
          />
        </div>

        <div className="labelMargin">
          <label className="labels">Email Address</label>
          <span style={{ padding: "5%"}}></span>
          <label className="labels rightColumnLabel">Password</label>

        </div>
        <div className="inputMargin">
          <input
            className="textBox"
            type="email"
            value={enteredEmailAddress}
            onChange={enteredEmailAddressChangeHandler}
          />
          <span style={{ padding: "5%"}}></span>
          <input
            className="textBox rightColumnTextBox"
            type="password"
            value={enteredPassword}
            onChange={enteredPasswordChangeHandler}
          />
        </div>
        <div className="btndiv">
          <button className="btn3" type="submit">Sign up</button>
        </div>
      </div>
    </form>
  );
};

export default PersonalUserForm;
