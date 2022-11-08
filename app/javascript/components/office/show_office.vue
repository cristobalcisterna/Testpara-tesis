<template>
  <section class="b-tooltips"> 
      <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px">
      <h1>Detalle de la dependencia</h1>
        <b-tabs type="is-boxed" position="is-centered">
           <b-tab-item label="Detalle de Dependencia">
               <div class="center"><h1>Información de la Dependencia</h1></div>
              <div class="box">
               
        <div v-if="office" class="columns is-centered">
          <div class="column is-centered">
            <div class="columns">
               <div class="column">
                <b-field label="Nombre dependencia:">
                  <b-input
                    v-model="office.name_office" type="text" readonly
                  ></b-input>
                </b-field>
              </div>
               <div class="column">
                <b-field label="Ubicación dependencia:">
                  <b-input
                    v-model=" office.location " type="text" readonly
                  ></b-input>
                </b-field>
              </div>
   
            </div>


            <div class="columns">
             
              <div class="column">
                <b-field label="Numero identificación dependencia:">
                  <b-input
                    v-model="office.identification_number_office " type="text" readonly
                  ></b-input>
             
                </b-field>
              </div>
               <div class="column">
                <b-field label="Identificación administración campus: ">
                  <b-input
                    v-model=" office.campus_identification" type="text" readonly
                  ></b-input>
                </b-field>
              </div>

             
            </div>
            <div class="columns">
             
              <div class="column">
                <b-field label="Horas semanales disponibles: ">
                  <b-input
                    v-model="office.hours_available" type="text" readonly
                  ></b-input>
                </b-field>
              </div>
              <div class="column">
                <b-field label="Metros cuadrados: ">
                  <b-input
                    v-model="office.square_meter" type="text" readonly
                  ></b-input>
                </b-field>
              </div>
            </div>

                        <div class="columns">
              <div class="column">
                <b-field label="Monto bruto total invertido en bienes: ">
                  <b-input
                    v-model="total" type="text" readonly
                  ></b-input>
                </b-field>
              </div>
            </div>

            <div class="columns">
             
              <div class="column" v-show='!(office.duty_manager.active_duty_manager == 0)'>
                <b-field label="Persona asociada: ">
                  <b-input
                  icon="eye"
                icon-clickable
                @icon-click="Clickshowdutymanager(office.duty_manager_id)"
                    v-model="office.duty_manager.name_duty_manager " type="text" readonly
                  ></b-input>
               
                </b-field>
              </div>

              <div class="column" v-show='(office.duty_manager.active_duty_manager== 0)'>
                <b-field label="Anterior persona asociada: ">
                  <b-input
                  icon="eye"
                icon-clickable
                
                    v-model="office.duty_manager.name_duty_manager " type="text" readonly
                  ></b-input>
               
                </b-field>
              </div>


              <div class="column">
                <b-field label="Edificio: ">
                  <b-input
                   icon="eye"
                icon-clickable
                @icon-click="Clickshowbuilding(office.building_id)"
                    v-model=" office.building.name_building " type="text" readonly
                  ></b-input>
                </b-field>
              </div>
            </div>
            <div class="columns">
                          <div class="column">
                <b-field label="Descripción de dependencia: ">
                  <b-input
                    v-model="office.office_description" type="textarea" readonly
                  ></b-input>
                </b-field>
              </div>
            </div>
          </div>
        </div>
        <div v-else><p>Loading</p></div>
              </div>
        </b-tab-item>


<b-tab-item label="Bienes en la dependencia">

        <div class="center"><h1>Bienes en la dependencia</h1></div>

    

          <div class="column">
            <b-table
              :data="goods"
              striped
              hoverable
              :paginated="true"
              per-page="8"
              :pagination-simple="false"
              pagination-position="bottom"
              default-sort-direction="asc"
              sort-icon="arrow-up"
              
              
            >
              <b-table-column
                :visible="false"
                field="id"
                label="ID"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>

              <b-table-column
                field="namegood"
                label="Nombre"
                sortable
                searchable
              >

                <template v-slot="props">
                  <a href="#" @click="Clickshowgood(props.row.id)">{{ props.row.namegood }}</a>
                </template>
              </b-table-column>

              <b-table-column
                field="identification_number_good"
                label="N° Inventario"
                sortable
                searchable
              >
                <template v-slot="props">
                  {{ props.row.identification_number_good }}
                </template>
              </b-table-column>

              <b-table-column
                field="duty_manager.name_duty_manager"
                label="Nombre persona asociada"
                sortable
                searchable
              >
                <template v-slot="props">
                   <a href="#" @click="Clickshowdutymanager(props.row.duty_manager_id)">{{ props.row.duty_manager.name_duty_manager }}</a>
                
                </template>
              </b-table-column>

              <b-table-column
                field="office.name_building"
                label="Edificio"
                sortable
                searchable
              >
                <template v-slot="props">
                  <a href="#" @click="Clickshowbuilding(props.row.office.building_id)">{{ props.row.office.name_building }}</a>

                </template>
              </b-table-column>

              <b-table-column
                field="office.name_office"
                label="Dependencia"
                sortable
                searchable
              >
                <template v-slot="props">
                 <a href="#" @click="Clickshowoffice(props.row.office_id)">{{ props.row.office.name_office }}</a>
                  
                </template>
              </b-table-column>



                            <b-table-column
                field="amount"
                label="Monto"
                sortable
                searchable
              >
                       <template v-slot="props">
                  {{ props.row.amount }}
                </template>
              </b-table-column>

              <b-table-column
                field="id"
                width="10"
                v-slot="props" 
                size="is-small"
              >
   <div class="columns">

                  <div class="column">
                  <b-tooltip label="Ver detalle" type="is-info"> 
<b-icon
              pack="fas"
              icon="eye"
              size="is-medium"
              @click.native="Clickshowgood(props.row.id)"/>
              </b-tooltip>
                  </div>

                  <div class="column">
                    <b-tooltip label="Anular" type="is-info">
                      <b-icon pack="fas" icon="trash" size="is-medium" @click.native="confirmGoodNull(props.row.id)" />
                    </b-tooltip>
                  </div>
     
                </div>

                


              </b-table-column>
  

            </b-table>

          </div>

          </b-tab-item>

      </b-tabs>
    </div>
    <a href="/offices"   style= "font-weight: normal;
  font-size: 20px;
  font-family: Arial;
  margin: 10px;
  margin-left: 30px;">Volver</a>
  </section>
</template>


<script>
import axios from "axios";
export default {
  props: ["id",'queryType', 'modalHeader','officeId'],
  data() {
    return {
      office: null,
      goods: [],
      goodamounts: null,
      total: null,
      props: ["id"],
      null_activegood: 0,
    };
  },
  methods: {
    async getoffices() {
      const response = await axios.get("/offices/" + this.officeId + ".json");
      this.office = response.data;
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


    async getgoodbyoffice() {
      const response = await axios.get("/goods/showgoodoffice/" + this.officeId + ".json");
      this.goods = response.data;
      this.goodamounts = this.goods.map(o => o['amount']);
      const c = 0;
      this.total = this.goodamounts.reduce((a, b) => a + b,c);
      console.log(this.goods);
      console.log(this.goodamounts);
      console.log(this.total);
    },


       async Clickshowgood(item) {
      const response = (window.location.href = "/goods/" + item);
    },
    async Clickeditgood(item) {
      const response = (window.location.href = "/goods/" + item + "/edit");
    },
    
    
    confirmGoodNull(item) {
                this.$buefy.dialog.confirm({
                    title: 'Anular Bien',
                    message: '¿Esta seguro de querer anular el bien?.',
                    confirmText: 'Anular',
                    cancelText: 'Cancelar',
                    type: 'is-danger',
                    hasIcon: true,
                    onConfirm: () => this.AnulClick(item)
                })
            },
    async AnulClick(item) {
      const response = await axios.put("/goods/" + item + ".json", {
        activegood: this.null_activegood,
        });
         window.location.href = "/offices/" + this.officeId ;
    },
  },
  created() {
    this.getoffices();
    this.getgoodbyoffice();
    
    
  },
};
</script>




