import { forwardRef, useEffect, useImperativeHandle, useState } from 'react';
import { storage } from '../../firebase';

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


    const allInputs = {imgUrl: ''};
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

    const submitHandler = (event) => {
        event.preventDefault();

        if(imageAsFile === '' ) {
            console.error(`not an image, the image file is a ${typeof(imageAsFile)}`)
        }

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
             setImageAsUrl(prevObject => ({...prevObject, imgUrl: fireBaseUrl}));
             
             const modifiedAccountInfo = {
                name: enteredName,
                dateOfBirth: new Date(enteredDateOfBirth),
                email: enteredEmailAddress,
                numVac: enteredNumberOfVaccinations,
                imageUrl: fireBaseUrl,
                address: {
                  street1: street1,
                  street2: street2,
                  city: city,
                  state: state,
                  postalCode: postalCode
                }
              };
            
              props.onModifyPatient(modifiedAccountInfo);
           })
        })

    }

    return (
    <form onSubmit={submitHandler}>
        <div>
            <img src={imageUrl} alt="avatar"/>
            <input type="file" onChange={handleImageAsFile}></input>
        </div>
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
            <label>Number of Vaccinations</label>
            <input
            type="number"
            value={enteredNumberOfVaccinations}
            onChange={enteredNumberOfVaccinationsChangeHandler}
            />
        </div>
        
        <div className="">
            <label>Address</label>
            <input
                type="text"
                value={street1}
                onChange={street1ChangeHandler}
                placeholder="Street Address 1"
            />
            <input
                type="text"
                value={street2}
                onChange={street2ChangeHandler}
                placeholder="Street Address 2"
            />
            <input
                type="text"
                value={city}
                onChange={cityChangeHandler}
                placeholder="City"
            ></input>
            <select value={state} onChange={stateChangeHandler}>
                <option value="" disabled selected>
                State
                </option>
                {states.map((state) => (
                <option value={state.abbreviation}>{state.name}</option>
                ))}
            </select>
            <input
                type="number"
                value={postalCode}
                onChange={postalCodeChangeHandler}
                placeholder="Postal Code"
            />
        </div>

        <div>
            <button type="submit">Modify Patient</button>
        </div>

    </form>
    );

});

export default UserInfoForm;