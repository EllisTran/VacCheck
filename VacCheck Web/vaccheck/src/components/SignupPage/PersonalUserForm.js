import { useState } from "react";
import './PersonalUserForm.css';

const PersonalUserForm = (props) => {
  const [enteredName, setEnteredName] = useState("");
  const [enteredDateOfBirth, setEnteredDateOfBirth] = useState("");
  // const [enteredIdentityDocumentType, setEnteredIdentityDocumentType] =
  //   useState("ssn");
  const [enteredIdentityNumber, setEnteredIdentityNumber] = useState("");
  const [enteredEmailAddress, setEnteredEmailAddress] = useState("");
  const [enteredPassword, setEnteredPassword] = useState("");

  const nameChangeHandler = (event) => {
    setEnteredName(event.target.value);
  };

  const dateOfBirthChangeHandler = (event) => {
    setEnteredDateOfBirth(event.target.value);
  };

  // const identityDocumentTypeChangeHandler = (event) => {
  //   setEnteredIdentityDocumentType(event.target.value);
  // };

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
    // setEnteredIdentityDocumentType("");
    setEnteredIdentityNumber("");
    setEnteredEmailAddress("");
    setEnteredPassword("");
  }

  const submitHandler = (event) => {
      event.preventDefault();

      const accountInfo = {
          name: enteredName,
          dateOfBirth: new Date(enteredDateOfBirth),
          // identityDocumentType: enteredIdentityDocumentType,
          identityNumber: enteredIdentityNumber,
          email: enteredEmailAddress,
          password: enteredPassword
      }
      clearAccountInfo();
      props.onSignup(accountInfo);
  }

  return (
    <form onSubmit={submitHandler}>
      <div>
        <div>
          <label className="fn" >Full Name</label>
          <input className = 'put1' type="text" value={enteredName} onChange={nameChangeHandler} />
        </div>
        <div>
          <label className="dateofbirth" >Date of Birth</label>
          <input
            className = "put2"
            type="date"
            min="1900-1-1"
            max="2021-12-31"
            value={enteredDateOfBirth}
            onChange={dateOfBirthChangeHandler}
          />
        </div>
        <div >
          <label className = "ssn">Social Security Number</label>
          {/* <select
            value={enteredIdentityDocumentType}
            onChange={identityDocumentTypeChangeHandler}
          >
            <option value="" diabled selected></option>
            <option value="ssn">Social Security Number</option>
            <option value="dl">Driver's License Number</option>
          </select> */}
          <input
            className = "put3"
            value={enteredIdentityNumber}
            onChange={identityNumberChangeHandler}
          />
        </div>
        <div>
          <label className = "EM">Email Address</label>
          <input className = "put4" type="email" value={enteredEmailAddress} onChange={enteredEmailAddressChangeHandler}/> 
        </div>
        <div>
          <label className = "pass" >Password</label>
          <input className = "put5" type="password" value={enteredPassword} onChange={enteredPasswordChangeHandler}/>
        </div>
        <div>
            <button className = 'btn' type="submit">Sign up</button>
        </div>
      </div>
    </form>
  );
};

export default PersonalUserForm;
