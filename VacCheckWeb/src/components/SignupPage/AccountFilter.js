import '../styling/AccountFilter.css'
const AccountFilter = (props) => {
  const selectChangeHandler = (event) => {
    props.onSelectAccountType(event.target.value);
  };

  return (
        <div className="select2">
          <select className="selects" value={props.select} onChange={selectChangeHandler}>
            <option value="" disabled selected>Create your VacCheck Account</option>
            <option value="PersonalUser">Personal User</option>
            <option value="Business">Business</option>
            <option value="HealthProfessional">Health Professional</option>
          </select>
     
      </div>
  );
};

export default AccountFilter;
