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

  // 読み込まれたページに"title"というid名の要素があれば発火(新規投稿と編集の際)
  if (document.getElementById("title") != null){
    // 編集ページへ遷移した際、すでにDBに保存されている値を出力
    showBeforeManHours.innerHTML = beforeManHours.value
    showBeforeCosts.innerHTML = beforeCosts.value
    showHourlyWage.innerHTML = hourlyWage.value
    showAfterManHours.innerHTML = afterManHours.value
    showAfterCosts.innerHTML = afterCosts.value
    showReducedManHours.innerHTML = reducedManHours.value
    showReducedCosts.innerHTML = reducedCosts.value
    // Beforeの計算式(どれか一つのフォームの値が変更されると再計算される)
    const beforeCalculation = () => {
      const beforeManHoursCalc = Math.round((beforeSeconds.value)*(beforeWorkers.value)*(beforeDays.value)*10/3600)/10;
      beforeManHours.value = beforeManHoursCalc
      showBeforeManHours.innerHTML = beforeManHoursCalc
      const beforeCostsCalc = Math.round((beforeManHours.value)*(hourlyWage.value));
      beforeCosts.value = beforeCostsCalc
      showBeforeCosts.innerHTML = beforeCostsCalc
      // Beforeの計算式(年間削減工数と年間削減コストは全てのフォームに値が入力された時に計算される)
      if((beforeSeconds.value != '') && (beforeWorkers.value != '') && (beforeDays.value != '') && (hourlyWage.value != '')
        && (afterSeconds.value != '') && (afterWorkers.value != '') && (afterDays.value != '')){
        const reducedManHoursCalc = Math.round(((beforeManHours.value)-(afterManHours.value))*10)/10;
        reducedManHours.value = reducedManHoursCalc
        showReducedManHours.innerHTML = reducedManHoursCalc
        const reducedCostsCalc = Math.round((beforeCosts.value)-(afterCosts.value));
        reducedCosts.value = reducedCostsCalc
        showReducedCosts.innerHTML = reducedCostsCalc
      };
    };
    
    // Afterの計算式(どれか一つのフォームの値が変更されると再計算される)
    const afterCalculation = () => {
      const afterManHoursCalc = Math.round((afterSeconds.value)*(afterWorkers.value)*(afterDays.value)*10/3600)/10;
      afterManHours.value = afterManHoursCalc
      showAfterManHours.innerHTML = afterManHoursCalc
      const afterCostsCalc = Math.round((afterManHours.value)*(hourlyWage.value));
      afterCosts.value = afterCostsCalc
      showAfterCosts.innerHTML = afterCostsCalc
      // Afterの計算式(年間削減工数と年間削減コストは全てのフォームに値が入力された時に計算される)
      if((beforeSeconds.value != '') && (beforeWorkers.value != '') && (beforeDays.value != '') && (hourlyWage.value != '')
        && (afterSeconds.value != '') && (afterWorkers.value != '') && (afterDays.value != '')){
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
      // 時給はBeforeとAfterで同じ値である為、Beforeの時給が入力された時点でAfterの時給も出力され計算される
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

  //改善提案実施ページで発火(newとeditのビュー及びエラーハンドリング時)
  const path = location.pathname
  if ((path.includes("proposals") && path.includes("executions")) || path.includes("executions/")){
    // 編集ページへ遷移した際、すでにDBに保存されている値を出力
    let showBeforeManHours = document.getElementById("show_before_man_hours");
    showBeforeManHours = showBeforeManHours.textContent;
    let showHourlyWage = document.getElementById("show_hourly_wage");
    showHourlyWage = showHourlyWage.textContent;
    let showBeforeCosts = document.getElementById("show_before_costs");
    showBeforeCosts = showBeforeCosts.textContent;
    showAfterManHours.innerHTML = afterManHours.value
    showAfterCosts.innerHTML = afterCosts.value
    showReducedManHours.innerHTML = reducedManHours.value
    showReducedCosts.innerHTML = reducedCosts.value
    // Afterの計算式(どれか一つのフォームの値が変更されると再計算される)
    const executionCalculation = () => {
      const afterManHoursCalc = Math.round((afterSeconds.value)*(afterWorkers.value)*(afterDays.value)*10/3600)/10;
      afterManHours.value = afterManHoursCalc
      showAfterManHours.innerHTML = afterManHoursCalc
      const afterCostsCalc = Math.round((afterManHours.value)*(showHourlyWage));
      afterCosts.value = afterCostsCalc
      showAfterCosts.innerHTML = afterCostsCalc
      hourlyWage.value = showHourlyWage
      // Afterの計算式(年間削減工数と年間削減コストは全てのフォームに値が入力された時に計算される)
      if((afterSeconds.value != '') && (afterWorkers.value != '') && (afterDays.value != '')){
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