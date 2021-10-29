import './AccountFilter.css'
import { ReactComponent as Vector1 } from './Vector1.svg';
import { ReactComponent as Vector2 } from './Vector2.svg';
import { ReactComponent as Vector3 } from './Vector3.svg';
import { ReactComponent as Vector4 } from './Vector4.svg';
const AccountFilter = (props) => {
  const selectChangeHandler = (event) => {
    props.onSelectAccountType(event.target.value);
  };


  return (
    <div>
      <h1 className = 'logo'> VacCheck </h1>
      <h1 className = 'title'  >Please choose your account type</h1>
      <select className = "select" value={props.select} onChange={selectChangeHandler}>
        <option  value="" disabled selected></option>
        <option  value="PersonalUser">Personal User</option>
        <option  value="Business">Business</option>
        <option  value="HealthProfessional">Health Professional</option>
      </select>
      <Vector1 className = "Vector1"/>
      <Vector2 className = "Vector2"/>
      <Vector3 className = "Vector3"/>
      <Vector4 className = "Vector4"/>
    </div>
  );
};

export default AccountFilter;
