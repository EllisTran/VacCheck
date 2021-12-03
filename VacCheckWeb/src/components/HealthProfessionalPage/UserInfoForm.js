import { forwardRef, useEffect, useImperativeHandle, useState } from 'react';
import { storage } from '../../firebase';
import './healthProfessionalPage.css';
import '../styling/SignupPage.css'
const UserInfoForm = forwardRef((props, ref) => {
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
    }
  ];


  const allInputs = { imgUrl: '' };
  const [imageAsFile, setImageAsFile] = useState('');
  const [imageAsUrl, setImageAsUrl] = useState(allInputs);

  const [imageUrl, setImageUrl] = useState((props.userData && props.userData.imageUrl) ? props.userData.imageUrl : "");
  // const [enteredImageUrl, setEnteredImageUrl] = useState();
  const [enteredName, setEnteredName] = useState((props.userData && props.userData.name) ? props.userData.name : "");
  const [enteredDateOfBirth, setEnteredDateOfBirth] = useState((props.userData && props.userData.dateOfBirth) ? new Date(props.userData.dateOfBirth.toDate()).toISOString().split('T')[0] : "");
  // const [enteredIdentityNumber, setEnteredIdentityNumber] = useState();
  const [enteredEmailAddress, setEnteredEmailAddress] = useState(props.userData ? props.userData.email : "");
  const [
    enteredNumberOfVaccinations,
    setEnteredNumberOfVaccinations,
  ] = useState((props.userData && props.userData.numVac) ? props.userData.numVac : 0);
  const [street1, setStreet1] = useState((props.userData && props.userData.address) ? props.userData.address.street1 : "");
  const [street2, setStreet2] = useState((props.userData && props.userData.address) ? props.userData.address.street2 : "");
  const [city, setCity] = useState((props.userData && props.userData.address) ? props.userData.address.city : "");
  const [state, setState] = useState((props.userData && props.userData.address) ? props.userData.address.state : "");
  const [postalCode, setPostalCode] = useState((props.userData && props.userData.address) ? props.userData.address.postalCode : "");

  useEffect(() => {
    setImageUrl(props.userData ? props.userData.imageUrl : "");
    setEnteredName((props.userData && props.userData.name) ? props.userData.name : "");
    setEnteredDateOfBirth((props.userData && props.userData.dateOfBirth) ? new Date(props.userData.dateOfBirth.toDate()).toISOString().split('T')[0] : null);
    setEnteredEmailAddress(props.userData ? props.userData.email : "");
    setEnteredNumberOfVaccinations((props.userData && props.userData.numVac) ? props.userData.numVac : 0);
    setStreet1((props.userData && props.userData.address) ? props.userData.address.street1 : "");
    setStreet2((props.userData && props.userData.address) ? props.userData.address.street2 : "");
    setCity((props.userData && props.userData.address) ? props.userData.address.city : "");
    setState((props.userData && props.userData.address) ? props.userData.address.state : "");
    setPostalCode((props.userData && props.userData.address) ? props.userData.address.postalCode : "");
  }, [props.userData]);

  useImperativeHandle(ref, () => ({

    updateImageUrl() {
      storage.ref().child(imageAsFile.name).getDownloadURL()
        .then(fireBaseUrl => {
          setImageUrl(fireBaseUrl);
        });
    }
  }));

  const handleImageAsFile = (e) => {
    console.log(imageUrl);
    const image = e.target.files[0];
    console.log(image);
    setImageAsFile(imageFile => (image));
  
  }

  const nameChangeHandler = (event) => {
    setEnteredName(event.target.value);
  };

  const dateOfBirthChangeHandler = (event) => {
    setEnteredDateOfBirth(event.target.value);
  };

  // const identityNumberChangeHandler = (event) => {
  // setEnteredIdentityNumber(event.target.value);
  // };

  const enteredEmailAddressChangeHandler = (event) => {
    setEnteredEmailAddress(event.target.value);
  };

  const enteredNumberOfVaccinationsChangeHandler = (event) => {
    setEnteredNumberOfVaccinations(parseInt(event.target.value));
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

  const modifyPatient = () => {
    const modifiedAccountInfo = {
      name: enteredName,
      dateOfBirth: new Date(enteredDateOfBirth),
      email: enteredEmailAddress,
      numVac: enteredNumberOfVaccinations,
      imageUrl: imageUrl,
      address: {
        street1: street1,
        street2: street2,
        city: city,
        state: state,
        postalCode: postalCode
      }
    };
    return modifiedAccountInfo;

  }

  const submitHandler = (event) => {
    event.preventDefault();

    if (imageAsFile === '') {
      console.error(`not an image, the image file is a ${typeof (imageAsFile)}`);
      let modifiedPatient = modifyPatient();
      props.onModifyPatient(modifiedPatient);
    } else {
      const uploadTask = storage.ref(`${imageAsFile.name}`).put(imageAsFile);

      uploadTask.on('state_changed',
        (snapShot) => {
          //takes a snap shot of the process as it is happening
          console.log(snapShot)
        }, (err) => {
          //catches the errors
          console.log(err)
        }, () => {
          // gets the functions from storage refences the image storage in firebase by the children
          // gets the download url then sets the image from firebase as the value for the imgUrl key:

          storage.ref().child(imageAsFile.name).getDownloadURL()
            .then(fireBaseUrl => {
              setImageAsUrl(prevObject => ({ ...prevObject, imgUrl: fireBaseUrl }));
              let modifiedPatient = modifyPatient();
              console.log(modifiedPatient);
              modifiedPatient.imageUrl = fireBaseUrl;
              props.onModifyPatient(modifiedPatient);
            })
        })
    }



  }

  return (
    <form onSubmit={submitHandler}>
      <div className="searchedUserView">
        <div className="photoView">
          <div className="photoContainer">
            <img src={imageUrl} className="searchedUserImage" alt="avatar" />
          </div>
          <div className="photoUploadView">
            <div className="photoUpload">
              <label for="file-upload" className="photoUploadLabel">Change Profile Photo</label>
              <input id="file-upload" style={{ display: "none" }} type="file"
                onChange={handleImageAsFile}
              ></input>

            </div>
          </div>

        </div>
        <div className="changeInfoForm">
          <div className="labelMargin">
            <label className="labels">Full Name</label>
            <span style={{ padding: "5%" }}></span>
            <label className="labels rightColumnLabel">Date of Birth</label>
          </div>
          <div>
            <input className="textBox" type="text" value={enteredName}
            onChange={nameChangeHandler}
            ></input>
            <span style={{ padding: "5%" }}></span>
            <input className="textBox rightColumnTextBox"
              type="date"
              min="1900-1-1"
              max="2021-12-31"
            ></input>
          </div>

          <div className="labelMargin">
            <label className="labels">Email Address</label>
            <span style={{ padding: "5%" }}></span>
            <label className="labels rightColumnLabel">Number of Vaccinations</label>
          </div>
          <div>
            <input className="textBox" type="email" value={enteredEmailAddress}
            onChange={enteredEmailAddressChangeHandler}
            ></input>
            <span style={{ padding: "5%" }}></span>
            <input className="textBox rightColumnTextBox" type="number" value={enteredNumberOfVaccinations}
             onChange={enteredNumberOfVaccinationsChangeHandler}
            ></input>
          </div>
          <div className="labelMargin">
            <label className="labels">Address</label>
          </div>
          <div className="inputMargins">

            <input
              className="textBox"
              type="text"
              value={street1}
              onChange={street1ChangeHandler}
              placeholder="Street Address 1"
            />
            <span style={{ padding: "5%" }}></span>
            <input
              className="textBox rightColumnTextBox"
              type="text"
              value={street2}
              onChange={street2ChangeHandler}
              placeholder="Street Address 2"
            />
            <input
              className="textBox"
              type="text"
              value={city}
              onChange={cityChangeHandler}
              placeholder="City"
            ></input>
            <span style={{ padding: "5%" }}></span>
            <select className="textBox rightColumnTextBox" value={state}
            onChange={stateChangeHandler}
            >
              <option value="" disabled selected>
                State
              </option>
              {states.map((state) => (
                <option value={state.abbreviation}>{state.name}</option>
              ))}
            </select>
            <input
              className="textBox"
              type="number"
              value={postalCode}
              onChange={postalCodeChangeHandler}
              placeholder="Postal Code"
            />
          </div>

          <div className="submitButtonDiv">
            <button className="searchButton submitButton" type="submit">Modify Patient</button>
          </div>
        </div>
      </div>
    </form>
  );

});

export default UserInfoForm;