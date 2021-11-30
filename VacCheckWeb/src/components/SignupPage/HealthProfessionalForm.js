import { useState } from "react";
import '../styling/HealthProfessionalForm.css'
const HealthProfessionalForm = (props) => {
  const states = [
    {
      name: "Alabama",
      abbreviation: "AL",
    },
    {
      name: "Alaska",
      abbreviation: "AK",
    },
    {
      name: "American Samoa",
      abbreviation: "AS",
    },
    {
      name: "Arizona",
      abbreviation: "AZ",
    },
    {
      name: "Arkansas",
      abbreviation: "AR",
    },
    {
      name: "California",
      abbreviation: "CA",
    },
    {
      name: "Colorado",
      abbreviation: "CO",
    },
    {
      name: "Connecticut",
      abbreviation: "CT",
    },
    {
      name: "Delaware",
      abbreviation: "DE",
    },
    {
      name: "District Of Columbia",
      abbreviation: "DC",
    },
    {
      name: "Federated States Of Micronesia",
      abbreviation: "FM",
    },
    {
      name: "Florida",
      abbreviation: "FL",
    },
    {
      name: "Georgia",
      abbreviation: "GA",
    },
    {
      name: "Guam",
      abbreviation: "GU",
    },
    {
      name: "Hawaii",
      abbreviation: "HI",
    },
    {
      name: "Idaho",
      abbreviation: "ID",
    },
    {
      name: "Illinois",
      abbreviation: "IL",
    },
    {
      name: "Indiana",
      abbreviation: "IN",
    },
    {
      name: "Iowa",
      abbreviation: "IA",
    },
    {
      name: "Kansas",
      abbreviation: "KS",
    },
    {
      name: "Kentucky",
      abbreviation: "KY",
    },
    {
      name: "Louisiana",
      abbreviation: "LA",
    },
    {
      name: "Maine",
      abbreviation: "ME",
    },
    {
      name: "Marshall Islands",
      abbreviation: "MH",
    },
    {
      name: "Maryland",
      abbreviation: "MD",
    },
    {
      name: "Massachusetts",
      abbreviation: "MA",
    },
    {
      name: "Michigan",
      abbreviation: "MI",
    },
    {
      name: "Minnesota",
      abbreviation: "MN",
    },
    {
      name: "Mississippi",
      abbreviation: "MS",
    },
    {
      name: "Missouri",
      abbreviation: "MO",
    },
    {
      name: "Montana",
      abbreviation: "MT",
    },
    {
      name: "Nebraska",
      abbreviation: "NE",
    },
    {
      name: "Nevada",
      abbreviation: "NV",
    },
    {
      name: "New Hampshire",
      abbreviation: "NH",
    },
    {
      name: "New Jersey",
      abbreviation: "NJ",
    },
    {
      name: "New Mexico",
      abbreviation: "NM",
    },
    {
      name: "New York",
      abbreviation: "NY",
    },
    {
      name: "North Carolina",
      abbreviation: "NC",
    },
    {
      name: "North Dakota",
      abbreviation: "ND",
    },
    {
      name: "Northern Mariana Islands",
      abbreviation: "MP",
    },
    {
      name: "Ohio",
      abbreviation: "OH",
    },
    {
      name: "Oklahoma",
      abbreviation: "OK",
    },
    {
      name: "Oregon",
      abbreviation: "OR",
    },
    {
      name: "Palau",
      abbreviation: "PW",
    },
    {
      name: "Pennsylvania",
      abbreviation: "PA",
    },
    {
      name: "Puerto Rico",
      abbreviation: "PR",
    },
    {
      name: "Rhode Island",
      abbreviation: "RI",
    },
    {
      name: "South Carolina",
      abbreviation: "SC",
    },
    {
      name: "South Dakota",
      abbreviation: "SD",
    },
    {
      name: "Tennessee",
      abbreviation: "TN",
    },
    {
      name: "Texas",
      abbreviation: "TX",
    },
    {
      name: "Utah",
      abbreviation: "UT",
    },
    {
      name: "Vermont",
      abbreviation: "VT",
    },
    {
      name: "Virgin Islands",
      abbreviation: "VI",
    },
    {
      name: "Virginia",
      abbreviation: "VA",
    },
    {
      name: "Washington",
      abbreviation: "WA",
    },
    {
      name: "West Virginia",
      abbreviation: "WV",
    },
    {
      name: "Wisconsin",
      abbreviation: "WI",
    },
    {
      name: "Wyoming",
      abbreviation: "WY",
    },
  ];

  const [fullName, setFullName] = useState("");
  // National Provider Identifier
  const [nip, setNip] = useState("");
  const [street1, setStreet1] = useState("");
  const [street2, setStreet2] = useState("");
  const [city, setCity] = useState("");
  const [state, setState] = useState("");
  const [postalCode, setPostalCode] = useState("");
  const [emailAddress, setEmailAddress] = useState("");
  const [password, setPassword] = useState("");

  const fullNameChangeHandler = (event) => {
    setFullName(event.target.value);
  };

  const nipChangeHandler = (event) => {
    setNip(event.target.value);
  };

  const street1ChangeHandler = (event) => {
    setStreet1(event.target.value);
  };

  const street2ChangeHandler = (event) => {
    setStreet2(event.target.value);
  };

  const cityChangeHandler = (event) => {
    setCity(event.target.value);
  };

  const stateChangeHandler = (event) => {
    setState(event.target.value);
  };

  const postalCodeChangeHandler = (event) => {
    setPostalCode(event.target.value);
  };

  const emailAddressChangeHandler = (event) => {
    setEmailAddress(event.target.value);
  };

  const passwordChangeHandler = (event) => {
    setPassword(event.target.value);
  };

  const clearAccountInfo = () => {
    setFullName("");
    setNip("");
    setStreet1("");
    setStreet2("")
    setCity("");
    setState("");
    setPostalCode("");
    setEmailAddress("");
    setPassword("");
}

  const submitHandler = (event) => {
    event.preventDefault();
    
    const accountInfo = {
        name: fullName,
        nip: nip,
        address: {
            street1: street1,
            street2: street2,
            city: city,
            state: state,
            postalCode: postalCode
        },
        email: emailAddress,
        password: password
    };

    clearAccountInfo();
    props.onSignup(accountInfo);
  };

  return (
    <form className="l" onSubmit={submitHandler}>
      <div>
        <div>
          <label className="full">Full Name</label>
          <input
          className="puth1"
            type="text"
            value={fullName}
            onChange={fullNameChangeHandler}
          />
        </div>
        <div>
          <label className="npi">National Provider Identifier</label>
          <input className="puth2" type="text" value={nip} onChange={nipChangeHandler} />
        </div>
        <div>
          <label className = "wa">Work Address</label>
          <input
          className="puth3"
            type="text"
            value={street1}
            onChange={street1ChangeHandler}
            placeholder="Street Address 1"
          />
          <input
          className="puth4"
            type="text"
            value={street2}
            onChange={street2ChangeHandler}
            placeholder="Street Address 2"
          />
          <input
          className="puth5"
            type="text"
            value={city}
            onChange={cityChangeHandler}
            placeholder="City"
          ></input>
          <select className="puth6" value={state} onChange={stateChangeHandler}>
            <option value="" disabled selected>
              State
            </option>
            {states.map((state) => (
              <option value={state.abbreviation}>{state.name}</option>
            ))}
          </select>
          <input
          className="puth7"
            type="number"
            value={postalCode}
            onChange={postalCodeChangeHandler}
            placeholder="Postal Code"
          />
        </div>
        <div>
          <label className="ea1">Email Address</label>
          <input className="puth8" type="email" value={emailAddress} onChange={emailAddressChangeHandler}/> 
        </div>
        <div>
          <label className="pass3">Password</label>
          <input className="puth9"type="password" value={password} onChange={passwordChangeHandler}/>
        </div>
      </div>
      <div>
        <button className="btn2"type="submit">Sign up</button>
      </div>
    </form>
  );
};

export default HealthProfessionalForm;
