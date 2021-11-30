import '../styling/AccountFilter.css'
import { ReactComponent as Vector1 } from '../styling/Vector1.svg';
import { ReactComponent as Vector2 } from '../styling/Vector2.svg';
import { ReactComponent as Vector3 } from '../styling/Vector3.svg';
import { ReactComponent as Vector4 } from '../styling/Vector4.svg';
const AccountFilter = (props) => {
  const selectChangeHandler = (event) => {
    props.onSelectAccountType(event.target.value);
  };

  return (
    <div>
      <h1 className="logo">VacCheck</h1>
      <h1 className="title">Choose your account type</h1>
      <select className="select" value={props.select} onChange={selectChangeHandler}>
        <option value="" disabled selected></option>
        <option value="PersonalUser">Personal User</option>
        <option value="Business">Business</option>
        <option value="HealthProfessional">Health Professional</option>
      </select>
      <Vector1 className = "Vector1"/>
      <Vector2 className = "Vector2"/>
      <Vector3 className = "Vector3"/>
      <Vector4 className = "Vector4"/>
    </div>
  );
};

export default AccountFilter;
