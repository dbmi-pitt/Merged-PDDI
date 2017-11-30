jQuery(document).ready(function($){
	// browser window scroll (in pixels) after which the "back to top" link is shown
	var offset = 300,
		//browser window scroll (in pixels) after which the "back to top" link opacity is reduced
		offset_opacity = 1200,
		//duration of the top scrolling animation (in ms)
		scroll_top_duration = 700,
		//grab the "back to top" link
		$back_to_top = $('.cd-top');

	//hide or show the "back to top" link
	$(window).scroll(function(){
		( $(this).scrollTop() > offset ) ? $back_to_top.addClass('cd-is-visible') : $back_to_top.removeClass('cd-is-visible cd-fade-out');
		if( $(this).scrollTop() > offset_opacity ) { 
			$back_to_top.addClass('cd-fade-out');
		}
	});

	//smooth scroll to top
	$back_to_top.on('click', function(event){
		event.preventDefault();
		$('body,html').animate({
			scrollTop: 0 ,
		 	}, scroll_top_duration
		);
	});

});


var calledOnce1 = false;
// get list of drug 2 based on drug 1
var calledOnce = false;


$(function(){
    getAvailableDrug1();    
});


// get all drug options including both precipitant and object
function getAvailableDrug1(){

    var currentSelectedDrug = $("#drugList1").val();
    var sources = document.getElementsByName('source');    
    var source = '';
    var j;
    for(j = 0; j < sources.length; j++) {
        if(sources[j].checked == true) {
            source += "'" + sources[j].value + "',";
        }
    }

    if(calledOnce1){
        $(".lbjs:eq(0)").remove();
        $(".lbjs:eq(1)").remove();        
    }
                            
    if(source){
        $.post( "drug_ajax", {source:source} )   
            .done(function( data ) {
		
                var ajaxData = data + "";                
                var drug1List = ajaxData.split(",");
		$("#drugList1").children().remove();
                $("#drugList2").children().remove();
                
                for(var i=0; i < drug1List.length; i++) {                    
                    $("#drugList1").append($('<option>').text(drug1List[i].replace('_',' ')).attr('value', drug1List[i]));
                }
                
                $("#drugList1").listbox({	                    
                    searchbar: true // enable a search bar to filter & search items
                });                                
                calledOnce1 = true;                
            });
    }
}

function getAvailableDrugPair() {

    var currentSelectedDrug = $("#drugList1").val();
    var sources = document.getElementsByName('source');
    
    var source = '';
    var j;
    for(j = 0; j < sources.length; j++) {
        if(sources[j].checked == true) {
            source += "'" + sources[j].value + "',";
        }
    }
    
    if(source){
        $.post( "drug_pair_ajax", {drug: currentSelectedDrug, source:source} )   
            .done(function( data ) {
		
                if(calledOnce){                    
                    $('.lbjs:eq(1)').remove();
                }
                var ajaxData = data + "";                
                var drug2List = ajaxData.split(",");
                
                $("#drugList2").html('');
                //alert($("#drugList2 option").size());
                //alert(drug2List.length);
                
                for(var i=0; i < drug2List.length; i++){
                    $("#drugList2").append($('<option>').text(drug2List[i].replace('_',' ')).attr('value', drug2List[i]));
                }
                                
                $("#drugList2").listbox({	                    
                    searchbar: true // enable a search bar to filter & search items
                });
		
                calledOnce = true;                
            });
    }    
}
                                            
                        
function changedruglist(drugExp){
    var drugExample = $(drugExp)[0].value;
    drugExample = drugExample.replace("e.g. ","");
    var drug1 = drugExample.split("/")[0];
    var drug2 = drugExample.split("/")[1];
    //alert(document.getElementById("drugList1").value);
    document.getElementById("drugList1").options[0].value = drug1;
    document.getElementById("drugList2").options[0].value = drug2;
    //alert(document.getElementById("drugList1").options[0].value);
}

function checkSources(category){
    var category1 = $(category).attr("id");
    //alert(category1);
    var catCheckStatus = document.getElementById(category1).checked;
    var inputset = document.getElementsByClassName(category1);
    var j;
    for(j = 0; j < inputset.length; j++)
    {
        if(catCheckStatus == true)
        {
            inputset[j].checked = true;
        }else{
            inputset[j].checked = false;
        }
    }
    
    getAvailableDrug1();    
}
                        
function checkSubSources(category){
    var category2 = $(category).attr("class");
    //alert(category2);
    var catCheckStatus=true;
    //var catCheckStatus = document.getElementById(category2).checked;
    var inputset = document.getElementsByClassName(category2);
    var j;
    for(j = 0; j < inputset.length; j++)
    {
        if(inputset[j].checked == false)                           	
            catCheckStatus = false;
    }
    if(catCheckStatus == false)
    {
        document.getElementById(category2).checked = false;
    }
    if(catCheckStatus == true)
    {
        document.getElementById(category2).checked = true;
    }
    getAvailableDrug1();
    //alert($(".lbjs").size());
}

function atLeastOneSource(){
    var sources = document.getElementsByName('source');
    var oneIsChecked = false;
    var submitButton = document.getElementById('findInteractionsSubmit');
    for(var i=0; i < sources.length; i++){
        if(sources[i].checked){
            oneIsChecked = true;
        }
    }
    if(oneIsChecked == true){
        submitButton.removeAttribute('disabled');
        document.getElementById('warningMessage').removeChild(document.getElementById('warningMessage').childNodes[0]);
    }
    else{
        submitButton.setAttribute('disabled', 'disabled');
        var message = document.createTextNode("At least one source must be checked!");
        document.getElementById('warningMessage').appendChild(document.createElement("p").appendChild(message));
    }
}
