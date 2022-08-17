window.addEventListener("load", ()=> {
  const beforeSeconds = document.getElementById("before_seconds");
  const beforeWorkers = document.getElementById("before_workers");
  const beforeDays = document.getElementById("before_days");
  const beforeManHours = document.getElementById("before_man_hours");
  const showBeforeManHours = document.getElementById("show_before_man_hours");
  const hourlyWage = document.getElementById("hourly_wage");
  const showHourlyWage = document.getElementById("show_hourly_wage");
  const beforeCosts = document.getElementById("before_costs");
  const showBeforeCosts = document.getElementById("show_before_costs");
  const afterSeconds = document.getElementById("after_seconds");
  const afterWorkers = document.getElementById("after_workers");
  const afterDays = document.getElementById("after_days");
  const afterManHours = document.getElementById("after_man_hours");
  const showAfterManHours = document.getElementById("show_after_man_hours");
  const afterCosts = document.getElementById("after_costs");
  const showAfterCosts = document.getElementById("show_after_costs");
  const reducedManHours = document.getElementById("reduced_man_hours");
  const showReducedManHours = document.getElementById("show_reduced_man_hours");
  const reducedCosts = document.getElementById("reduced_costs");
  const showReducedCosts = document.getElementById("show_reduced_costs");

  if (document.getElementById("identification") != null){
  // 読み込まれたページに"identification"というid名の要素があれば発火(新規投稿の際)
    const beforeCalculation = () => {
      const beforeManHoursCalc = Math.round((beforeSeconds.value)*(beforeWorkers.value)*(beforeDays.value)*10/3600)/10;
      beforeManHours.value = beforeManHoursCalc
      showBeforeManHours.innerHTML = beforeManHoursCalc
      const beforeCostsCalc = Math.round((beforeManHours.value)*(hourlyWage.value));
      beforeCosts.value = beforeCostsCalc
      showBeforeCosts.innerHTML = beforeCostsCalc
      if((beforeSeconds.value != 0) && (beforeWorkers.value != 0) && (beforeDays.value != 0) && (hourlyWage.value != 0) && (afterSeconds.value != 0) && (afterWorkers.value != 0) && (afterDays.value != 0)){
        const reducedManHoursCalc = Math.round(((beforeManHours.value)-(afterManHours.value))*10)/10;
        reducedManHours.value = reducedManHoursCalc
        showReducedManHours.innerHTML = reducedManHoursCalc
        const reducedCostsCalc = Math.round((beforeCosts.value)-(afterCosts.value));
        reducedCosts.value = reducedCostsCalc
        showReducedCosts.innerHTML = reducedCostsCalc
      };
    };
    const afterCalculation = () => {
      const afterManHoursCalc = Math.round((afterSeconds.value)*(afterWorkers.value)*(afterDays.value)*10/3600)/10;
      afterManHours.value = afterManHoursCalc
      showAfterManHours.innerHTML = afterManHoursCalc
      const afterCostsCalc = Math.round((afterManHours.value)*(hourlyWage.value));
      afterCosts.value = afterCostsCalc
      showAfterCosts.innerHTML = afterCostsCalc
      if((beforeSeconds.value != 0) && (beforeWorkers.value != 0) && (beforeDays.value != 0) && (hourlyWage.value != 0) && (afterSeconds.value != 0) && (afterWorkers.value != 0) && (afterDays.value != 0)){
        const reducedManHoursCalc = Math.round(((beforeManHours.value)-(afterManHours.value))*10)/10;
        reducedManHours.value = reducedManHoursCalc
        showReducedManHours.innerHTML = reducedManHoursCalc
        const reducedCostsCalc = Math.round((beforeCosts.value)-(afterCosts.value));
        reducedCosts.value = reducedCostsCalc
        showReducedCosts.innerHTML = reducedCostsCalc
      };
    };
    beforeSeconds.addEventListener("input",() => {
      beforeCalculation()
    });
    beforeWorkers.addEventListener("input",() => {
      beforeCalculation()
    });
    beforeDays.addEventListener("input",() => {
      beforeCalculation()
    });
    hourlyWage.addEventListener("input",() => {
      beforeCalculation()
      showHourlyWage.innerHTML = hourlyWage.value
      const afterCostsCalc = Math.round((afterManHours.value)*(hourlyWage.value));
      afterCosts.value = afterCostsCalc
      showAfterCosts.innerHTML = afterCostsCalc
    });
    afterSeconds.addEventListener("input",() => {
      afterCalculation()
    });
    afterWorkers.addEventListener("input",() => {
      afterCalculation()
    });
    afterDays.addEventListener("input",() => {
      afterCalculation()
    });
  };

  const path = location.pathname
  if (path.includes("executions") && path.includes("new")){
  //読み込まれたパスにexecutionsとnewが含まれていれば発火(改善提案実行の際)
    let showBeforeManHours = document.getElementById("show_before_man_hours");
    showBeforeManHours = showBeforeManHours.textContent;
    let showHourlyWage = document.getElementById("show_hourly_wage");
    showHourlyWage = showHourlyWage.textContent;
    let showBeforeCosts = document.getElementById("show_before_costs");
    showBeforeCosts = showBeforeCosts.textContent;
    const executionCalculation = () => {
      const afterManHoursCalc = Math.round((afterSeconds.value)*(afterWorkers.value)*(afterDays.value)*10/3600)/10;
      afterManHours.value = afterManHoursCalc
      showAfterManHours.innerHTML = afterManHoursCalc
      const afterCostsCalc = Math.round((afterManHours.value)*(showHourlyWage));
      afterCosts.value = afterCostsCalc
      showAfterCosts.innerHTML = afterCostsCalc
      hourlyWage.value = showHourlyWage
      if((afterSeconds.value != 0) && (afterWorkers.value != 0) && (afterCosts.value != 0)){
        const reducedManHoursCalc = Math.round(((showBeforeManHours)-(afterManHours.value))*10)/10;
        reducedManHours.value = reducedManHoursCalc
        showReducedManHours.innerHTML = reducedManHoursCalc
        const reducedCostsCalc = Math.round((showBeforeCosts)-(afterCosts.value));
        reducedCosts.value = reducedCostsCalc
        showReducedCosts.innerHTML = reducedCostsCalc
      };
    };
    afterSeconds.addEventListener("input",() => {
      executionCalculation()
    });
    afterWorkers.addEventListener("input",() => {
      executionCalculation()
    });
    afterDays.addEventListener("input",() => {
      executionCalculation()
    });
  };
});