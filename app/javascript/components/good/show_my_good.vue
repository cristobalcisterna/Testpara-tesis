<template>
    <section>
  
      <div
        class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px"
      >
  
  
      
  
  
          <b-modal :active="isModalnewstatus" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
                 width="100%" :can-cancel="canCancel">
            <template>
              <new-condition-good :good-id="goodId" :id="selected" :modal-header="'Reportar Bien'" query-type="create"
                @close="closeModalCreateStatus"></new-condition-good>
            </template>
          </b-modal>
  
  
  
  
  
  
          <div v-if="good" class="columns is-centered">
            <div class="column is-centered">
  
                    <div class="columns">
          <div class="column">
            <h1>Detalle del Bien</h1>
          </div>
         

                 <div
            class="has-text-right"
            style="margin-top: 60px; margin-left: 3px; margin-right: 3px"
            :hidden="good.activegood == 0  || good.activegood == 2"
          >
            <b-button
              label="Dar de baja Bien"
              type="is-info"
              icon-left="pen-to-square"
              :disabled="good.activegood == 0"
              @click="createConditionGood(goodId)"
            />
          </div>
  

  
        </div>
              <div class="columns">
                <div class="column">
                  <b-field label="Nombre:">
                    <b-input
                      v-model="good.namegood"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
  
                <div class="column">
                  <b-field label="Marca:">
                    <b-input
                      v-model="good.trademark"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
              </div>
      
              <div class="columns">
                <div class="column">
                  <b-field label="Numero identificación Usach:">
                    <b-input
                      v-model="good.identification_number_usach"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
                <div class="column">
                  <b-field label="Numero de serie: ">
                    <b-input
                      v-model="good.serie_number"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
              </div>
  
              <div class="columns">
                <div class="column">
                  <b-field label="Numero interno:">
                    <b-input
                      v-model="good.internal_number"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
                <div class="column">
                  <b-field label="Numero identificación:">
                    <b-input
                      v-model="good.identification_number_good"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
              </div>
  
                          <div class="columns">
                <div class="column">
                  <b-field label="Monto Bruto: ">
                    <b-input
                      v-model="good.amount"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
  
                <div class="column">
                  <b-field label="Fecha de compra:"> 
                    <b-input
                      v-model="auxdatebuy"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
              </div>
  
  
  
  
  
  
  
  
  
  
                          <div class="columns">
                <div class="column">
                  <b-field label="Fuente de Financiamiento: ">
                   <b-input
                  
                      v-model="good.financial_source.name_financial_source"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
  
                              <div class="column">
                  <b-field label="Tipo de inversión: ">
                   <b-input
                      v-model="good.investment_type.name_investment_type"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
              </div>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
              <div class="columns" v-show='!(good.activegood == 2)'>
                <div class="column">
                  <b-field label="Fecha de asignación: "> 
                    <b-input
                      v-model="auxdatedesign"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
  
                <div class="column">
                  <b-field label="Persona encargada: ">
                    <b-input
                      v-model="good.duty_manager.name_duty_manager"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
              </div>
  
              <div class="columns" v-show='!(good.activegood == 2)'>
                <div class="column">
                  <b-field label="Unidad: ">
                    <b-input
                      v-model="good.duty_manager.name_unit"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
  
                <div class="column">
                  <b-field label="Edificio: ">
                    <b-input
                      v-model="good.office.name_building"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
              </div>
              <div class="columns" v-show='!(good.activegood == 2)'>
                <div class="column">
                  <b-field label="Dependencia: ">
                    <b-input
                      v-model="good.office.name_office"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
  
                <div class="column">
                  <b-field label="Ubicación: ">
                    <b-input
                      v-model="good.location_good"
                      type="text"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
              </div>
              <div class="columns">
                <div class="column">
                  <b-field label="Descripción:">
                    <b-input
                      v-model="good.good_description"
                      type="textarea"
                      readonly
                    ></b-input>
                  </b-field>
                </div>
              </div>
            </div>
          </div>
          <div v-else>
            <p>Loading</p>
          </div>
      </div>
      <a href="/duty_managers/mygoods"   style= "font-weight: normal;
    font-size: 20px;
    font-family: Arial;
    margin: 10px;
    margin-left: 30px;">Volver</a>
    </section>
  </template>
  
   
  <script>
  import axios from "axios";
  import IndexGoods from "./index_good.vue";
  import EditGood from "./edit_good.vue";
  import NewConditionGood from "../condition_good/new_condition_good.vue"; 
  import moment from "moment";
  
  export default {
    name:"show_good",
    components: {
      "index-good": 
      IndexGoods,
      NewConditionGood,
      EditGood,

    },
    props: ["goodId", "id",'queryType', 'modalHeader',],
    
    data() {
      return {
        good: null,
        null_activegood: 0,
         des_activegood: 1,
        selected: null,
        auxdatebuy: [],
        auxdatedesign: [], 
        canCancel: ["escape"],
        isModalnewstatus: false,
        props: ["id"],
      };
    },
    methods: {
      async getgoods() {
        const response = await axios.get("/goods/" + this.goodId + ".json");
        this.good = response.data;
        //this.auxdate=  JSON.stringify(moment(this.good["date_release"], ["YYYY-MM-DD","DD-MM-YYYY"]));
        this.auxdatebuy= this.formatdate(this.good.date_release)
        this.auxdatedesign= this.formatdate(this.good.date_purchase)
  
  
      },

      async Clickeditgood(item) {
        const response = (window.location.href = "/goods/" + item + "/edit");
      },

  
      async createConditionGood(item) {
        this.selected = item;
        
        this.isModalnewstatus = true;
      },
  
      async closeModalCreateStatus() {
        this.isModalnewstatus = false;
      },
  
      formatdate(date){
        if(date!=null && date!="" && date!=undefined){
          var arreglo = date.split("-")
          return arreglo[2]+"-"+arreglo[1]+"-"+arreglo[0]
        }
        else{ 
          return ""
          }
        },
  
    },
    created() {
      this.getgoods();
      console.log(this.cargoActivo);
    },
  };
  </script>
  
  
  
  
  