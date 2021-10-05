import { useState } from "react";

const PersonalUserForm = (props) => {
  const [enteredName, setEnteredName] = useState("");
  const [enteredDateOfBirth, setEnteredDateOfBirth] = useState("");
  const [enteredIdentityDocumentType, setEnteredIdentityDocumentType] =
    useState("ssn");
  const [enteredIdentityNumber, setEnteredIdentityNumber] = useState("");
  const [enteredEmailAddress, setEnteredEmailAddress] = useState("");
  const [enteredPassword, setEnteredPassword] = useState("");

  const nameChangeHandler = (event) => {
    setEnteredName(event.target.value);
  };

  const dateOfBirthChangeHandler = (event) => {
    setEnteredDateOfBirth(event.target.value);
  };

  const identityDocumentTypeChangeHandler = (event) => {
    setEnteredIdentityDocumentType(event.target.value);
  };

  const identityNumberChangeHandler = (event) => {
    setEnteredIdentityNumber(event.target.value);
  };

  const enteredEmailAddressChangeHandler = (event) => {
    setEnteredEmailAddress(event.target.value);
  }

  const enteredPasswordChangeHandler = (event) => {
    setEnteredPassword(event.target.value);
  }

  const clearAccountInfo = () => {
    setEnteredName("");
    setEnteredDateOfBirth("");
    setEnteredIdentityDocumentType("");
    setEnteredIdentityNumber("");
    setEnteredEmailAddress("");
    setEnteredPassword("");
  }

  const submitHandler = (event) => {
      event.preventDefault();

      const accountInfo = {
          name: enteredName,
          dateOfBirth: new Date(enteredDateOfBirth),
          identityDocumentType: enteredIdentityDocumentType,
          identityNumber: enteredIdentityNumber,
          email: enteredEmailAddress,
          password: enteredPassword
      }
      clearAccountInfo();
      props.onSignup(accountInfo);
  }

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
        <div className="">
          <label>Choose your identity document type</label>
          <select
            value={enteredIdentityDocumentType}
            onChange={identityDocumentTypeChangeHandler}
          >
            <option value="" diabled selected></option>
            <option value="ssn">Social Security Number</option>
            <option value="dl">Driver's License Number</option>
          </select>
          <input
            value={enteredIdentityNumber}
            onChange={identityNumberChangeHandler}
          />
        </div>
        <div>
          <label>Email Address</label>
          <input type="email" value={enteredEmailAddress} onChange={enteredEmailAddressChangeHandler}/> 
        </div>
        <div>
          <label>Password</label>
          <input type="password" value={enteredPassword} onChange={enteredPasswordChangeHandler}/>
        </div>
        <div>
            <button type="submit">Sign up</button>
        </div>
      </div>
    </form>
  );
};

export default PersonalUserForm;
