import { useState } from "react";

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
      imageUrl: "",
    };
    console.log(accountInfo);
    clearAccountInfo();
    props.onSignup(accountInfo);
  };

  return (
    <form onSubmit={submitHandler}>
      <div className="">
        <div className="">
          <label>Full Name</label>
          <input type="text" value={enteredName} onChange={nameChangeHandler} />
        </div>
        <div className="">
          <label>Date of Birth</label>
          <input
            type="date"
            min="1900-1-1"
            max="2021-12-31"
            value={enteredDateOfBirth}
            onChange={dateOfBirthChangeHandler}
          />
        </div>

        <div>
          <label>Email Address</label>
          <input
            type="email"
            value={enteredEmailAddress}
            onChange={enteredEmailAddressChangeHandler}
          />
        </div>
        <div>
          <label>Password</label>
          <input
            type="password"
            value={enteredPassword}
            onChange={enteredPasswordChangeHandler}
          />
        </div>
        <div>
          <button type="submit">Sign up</button>
        </div>
      </div>
    </form>
  );
};

export default PersonalUserForm;
