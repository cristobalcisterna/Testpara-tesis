<template>
  <section>

    <div
      class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px">

        <div v-if="condition_good" class="columns is-centered">
          <div class="column is-centered">

                  <div class="columns">
        <div class="column">
          <h1>Detalle del Reporte</h1>
        </div>
       

      </div>
            <div class="columns">
              <div class="column">
                <b-field label="Nombre:">
                  <b-input
                   icon="eye"
                icon-clickable
                @icon-click="Clickshowgood(condition_good.good_id)"
                    v-model="condition_good.good.namegood"
                    type="text"
                    readonly
                  ></b-input>
                </b-field>
              </div>

            </div>


                       <div class="columns">
              <div class="column">
                <b-field label="Estado:">
                  <b-input
                   icon="eye"
                icon-clickable
                @icon-click="Clickshowgood(condition_good.condition_id)"
                    v-model="condition_good.condition.state_name"
                    type="text"
                    readonly
                  ></b-input>
                </b-field>
              </div>

            </div>







            <div class="columns">
              <div class="column" v-show='!(auxdaterequest == [])'>
                <b-field label="Fecha solicitud:">
                  <b-input
                    v-model="auxdaterequest"
                    type="text"
                    readonly
                  ></b-input>
                </b-field>
              
              </div>

              <div class="column" v-show='!(auxdatein == [])'>
                <b-field label="Fecha ingreso:">
                  <b-input
                    v-model="auxdatein"
                    type="text"
                    readonly
                  ></b-input>
                </b-field>
               
              </div>
                           <div class="column" v-show='!(auxdatelost == [])'>
                <b-field label="Fecha de pérdida:">
                  <b-input
                    v-model="auxdatelost"
                    type="text"
                    readonly
                  ></b-input>
                </b-field>
               
              </div>
                           <div class="column" v-show='!(auxdatedes == [])'>
                <b-field label="Fecha de Destrucción:">
                  <b-input
                    v-model="auxdatedes"
                    type="text"
                    readonly
                  ></b-input>
                </b-field>
               
              </div>

            </div>

            <div class="columns">
              <div class="column" v-show='!(condition_good.income_reason == null)'>
                <b-field label="Motivo ingreso:" >
                  <b-input
                    v-model="condition_good.income_reason"
                    type="textarea"
                    readonly
                  ></b-input>
                </b-field>
              </div>
          
              

                            <div class="column"  v-show='!(condition_good.loss_detail == null)'>
                <b-field label="Detalle de pérdida:">
                  <b-input
                    v-model="condition_good.loss_detail"
                    type="textarea"
                    readonly
                  ></b-input>
                </b-field>
              </div>
              

                            <div class="column" v-show='!(condition_good.destruction_detail == null)'>
                <b-field label="Detalle de destrucción:">
                  <b-input
                    v-model="condition_good.destruction_detail"
                    type="textarea"
                    readonly
                  ></b-input>
                </b-field>
              </div>

</div>
       
                      <div class="columns">
              <div class="column" v-show='!(condition_good.repairable == null)'>
                <b-field label="Es reparable:">
                  <b-input
                    v-model="condition_good.repairable"
                    type="text"
                    readonly
                  ></b-input>
                </b-field>
              
              </div>
              </div>

               <div class="columns">
               <div class="column" v-show='!(condition_good.good.activegood == 3)'>
                <b-field label="Persona encargada: ">
                  <b-input
                icon="eye"
                icon-clickable
                @icon-click="Clickshowdutymanager(condition_good.good.duty_manager_id)"
                    v-model="condition_good.good.name_duty_manager"
                    type="text"
                    readonly
                  ></b-input>
                </b-field>
              </div>
              </div>
 

             <div class="columns">
              <div class="column" v-show='!(condition_good.good.activegood == 3)'>
                <b-field label="Unidad: ">
                  <b-input
                  icon="eye"
                icon-clickable
                @icon-click="Clickshowunit(condition_good.good.unit_id)"
                    v-model="condition_good.good.name_unit"
                    type="text"
                    readonly
                  ></b-input>
                </b-field>
              </div>
              </div>
            
             <div class="columns">
              <div class="column" v-show='!(condition_good.good.activegood == 3)'>
                <b-field label="Edificio: ">
                  <b-input
                                  icon="eye"
                icon-clickable
                @icon-click="Clickshowbuilding(condition_good.good.building_id)"
                    v-model="condition_good.good.name_building"
                    type="text"
                    readonly
                  ></b-input>
                </b-field>
              </div>
              </div>
            
             <div class="columns">
              <div class="column" v-show='!(condition_good.good.activegood == 3)'>
                <b-field label="Dependencia: ">
                  <b-input
                icon="eye"
                icon-clickable
                @icon-click="Clickshowoffice(condition_good.good.office_id)"
                    v-model="condition_good.good.name_office"
                    type="text"
                    readonly
                  ></b-input>
                </b-field>
              </div>
              </div>





            <div class="columns">
              <div class="column">
                <b-field label="Link de documento:">
                  <b-input
                    v-model="condition_good.link"
                    type="text"
                    readonly
                    expanded
                  ></b-input>
                  <p>
                <b-button label="Ir a URL" type="is-info" @click="Clickshowlink(condition_good.link)"/>
            </p>
                </b-field>
              </div>






  
            </div>
          </div>
        </div>
        <div v-else>
          <p>Loading</p>
        </div>
    </div>
    <a href="/condition_goods"   style= "font-weight: normal;
  font-size: 20px;
  font-family: Arial;
  margin: 10px;
  margin-left: 30px;">Volver</a>
  </section>
</template>

 
<script>
import axios from "axios";
import moment from "moment";

export default {
  name:"show_good",
  props: ["condition_goodId", "id",'queryType', 'modalHeader'],
  
  data() {
    return {
      condition_good: null,
      null_activegood: 0,
       des_activegood: 1,
      selected: null,
      auxdaterequest:[],
      auxdatein:[],
      auxdatedes:[],
      auxdatelost:[],
      canCancel: ["escape"],
      isModalActiveEdit: false,
      props: ["id"],
    };
  },
  methods: {
    async getconditiongoods() {
      const response = await axios.get("/condition_goods/" + this.condition_goodId + ".json");
      this.condition_good = response.data;
      this.auxdaterequest= this.formatdate(this.condition_good.request_date)
      this.auxdatein= this.formatdate(this.condition_good.date_entry)
      this.auxdatedes= this.formatdate(this.condition_good.destruction_date)
      this.auxdatelost= this.formatdate(this.condition_good.lost_date)
      console.log(this.auxdate);
    },
           
        async RestClick(item) {
      const response = await axios.put("/goods/" + item + ".json", {
        activegood: this.des_activegood,
      });
      window.location.href = "/goods";
    },

async Clickshowlink(item) {
      window.open(item);
    },
        async Clickshowgood(item) {
      const response = (window.location.href = "/goods/" + item );
    },

    async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item );
    },
            async Clickshowbuilding(item) {
      const response = (window.location.href = "/buildings/" + item );
    },
      async Clickshowoffice(item) {
      const response = (window.location.href = "/offices/" + item );
    },
        async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },
    confirmGoodRest(item) {
      this.$buefy.dialog.confirm({
        title: "Restaurar Bien",
        message: "¿Esta seguro de querer restaurar el bien?.",
        confirmText: "Restaurar",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.RestClick(item),
      });
    },
            async editGood(item) {
          this.selected = item;
          this.isModalActiveEdit = true;
    },
    async closeModalEdit() {
      this.isModalActiveEdit = false;
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
    this.getconditiongoods();
  },
};
</script>
 



