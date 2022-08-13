window.addEventListener("load", ()=> {
  const path = location.pathname
  if (path.includes("proposals") && path.includes("new")){
  const beforeSeconds = document.getElementById("before_seconds");
  const beforeWorkers = document.getElementById("before_workers");
  const beforeDays = document.getElementById("before_days");
  const beforeManHours = document.getElementById("before_man_hours");
  const hideBeforeManHours = document.getElementById("hide_before_man_hours");
  const hourlyWage = document.getElementById("hourly_wage");
  const hideHourlyWage = document.getElementById("hide_hourly_wage");
  const beforeCosts = document.getElementById("before_costs");
  const hideBeforeCosts = document.getElementById("hide_before_costs");
  const afterSeconds = document.getElementById("after_seconds");
  const afterWorkers = document.getElementById("after_workers");
  const afterDays = document.getElementById("after_days");
  const afterManHours = document.getElementById("after_man_hours");
  const hideAfterManHours = document.getElementById("hide_after_man_hours");
  const afterCosts = document.getElementById("after_costs");
  const hideAfterCosts = document.getElementById("hide_after_costs");
  const reducedManHours = document.getElementById("reduced_man_hours");
  const hideReducedManHours = document.getElementById("hide_reduced_man_hours");
  const reducedCosts = document.getElementById("reduced_costs");
  const hideReducedCosts = document.getElementById("hide_reduced_costs");
  const before_calculation = () => {
    const beforeManHoursCalc = Math.round((beforeSeconds.value)*(beforeWorkers.value)*(beforeDays.value)*10/3600)/10;
    beforeManHours.value = beforeManHoursCalc
    hideBeforeManHours.innerHTML = beforeManHoursCalc
    const beforeCostsCalc = Math.round((beforeManHours.value)*(hourlyWage.value));
    beforeCosts.value = beforeCostsCalc
    hideBeforeCosts.innerHTML = beforeCostsCalc
    const reducedManHoursCalc = Math.round(((beforeManHours.value)-(afterManHours.value))*10)/10;
    reducedManHours.value = reducedManHoursCalc
    hideReducedManHours.innerHTML = reducedManHoursCalc
    const reducedCostsCalc = Math.round((beforeCosts.value)-(afterCosts.value));
    reducedCosts.value = reducedCostsCalc
    hideReducedCosts.innerHTML = reducedCostsCalc
  };
  const after_calculation = () => {
    const afterManHoursCalc = Math.round((afterSeconds.value)*(afterWorkers.value)*(afterDays.value)*10/3600)/10;
    afterManHours.value = afterManHoursCalc
    hideAfterManHours.innerHTML = afterManHoursCalc
    const afterCostsCalc = Math.round((afterManHours.value)*(hourlyWage.value));
    afterCosts.value = afterCostsCalc
    hideAfterCosts.innerHTML = afterCostsCalc
    const reducedManHoursCalc = Math.round(((beforeManHours.value)-(afterManHours.value))*10)/10;
    reducedManHours.value = reducedManHoursCalc
    hideReducedManHours.innerHTML = reducedManHoursCalc
    const reducedCostsCalc = Math.round((beforeCosts.value)-(afterCosts.value));
    reducedCosts.value = reducedCostsCalc
    hideReducedCosts.innerHTML = reducedCostsCalc
  };
  beforeSeconds.addEventListener("input",() => {
    before_calculation ()
  });
  beforeWorkers.addEventListener("input",() => {
    before_calculation ()
  });
  beforeDays.addEventListener("input",() => {
    before_calculation ()
  });
  hourlyWage.addEventListener("input",() => {
    const beforeManHoursCalc = Math.round((beforeSeconds.value)*(beforeWorkers.value)*(beforeDays.value)*10/3600)/10;
    beforeManHours.value = beforeManHoursCalc
    const beforeCostsCalc = Math.round((beforeManHours.value)*(hourlyWage.value));
    beforeCosts.value = beforeCostsCalc
    hideBeforeCosts.innerHTML = beforeCostsCalc
    hideHourlyWage.innerHTML = hourlyWage.value
    const afterCostsCalc = Math.round((afterManHours.value)*(hourlyWage.value));
    afterCosts.value = afterCostsCalc
    hideAfterCosts.innerHTML = afterCostsCalc
    const reducedManHoursCalc = Math.round(((beforeManHours.value)-(afterManHours.value))*10)/10;
    reducedManHours.value = reducedManHoursCalc
    hideReducedManHours.innerHTML = reducedManHoursCalc
    const reducedCostsCalc = Math.round((beforeCosts.value)-(afterCosts.value));
    reducedCosts.value = reducedCostsCalc
    hideReducedCosts.innerHTML = reducedCostsCalc
  });
  afterSeconds.addEventListener("input",() => {
    after_calculation ()
  });
  afterWorkers.addEventListener("input",() => {
    after_calculation ()
  });
  afterDays.addEventListener("input",() => {
    after_calculation ()
  });
 };
});