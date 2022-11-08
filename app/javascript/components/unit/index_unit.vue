<template>
  <section class="b-tooltips">
    <div
      class="box"
      style="margin-top: 60px; margin-left: 300px; margin-right: 300px"
    >
      <h1>Unidades de la facultad</h1>

      <b-tabs type="is-boxed" position="is-centered">
        <b-tab-item label="Unidades">


          <div class="has-text-right">
            <b-button
              label="Añadir unidad"
              type="is-info"
              icon-left="plus"
              @click="createUnit()"
            ></b-button>
          </div>
    
                    <div class="center">
            <h1>Unidades</h1>
          </div>
          <div> 
            <b-modal
              :active="isModalActive"
              aria-modal
              has-modal-card
              :destroy-on-hide="true"
              aria-role="dialog"
              width="100%"
              :can-cancel="canCancel"
            >
              <template>
                <new-unit
                  modal-cancel="true"
                  :modal-header="'Registro de Unidad'"
                  query-type="create"
                  @close="closeModalCreate"
                ></new-unit>
              </template>
            </b-modal>



            <b-modal :active="isModalActiveEdit" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <edit-unit :unit-id="unitId" :id="selected" :modal-header="'Editar Unidad'" query-type="update"
                  @close="closeModalEdit"></edit-unit>
              </template>
            </b-modal>




          </div>
          <div class="column">
            <b-table
              id="table"
              :data="units"
              :paginated="true"
              per-page="8"
              striped
              hoverable
              :pagination-simple="false"
              pagination-active-color="hsl(0, 0%, 0%)"
              pagination-position="bottom"
              default-sort-direction="asc"
              sort-icon="arrow-up"
              aria-next-label="Siguiente"
              aria-previous-label="Anterior"
              aria-page-label="Página"
              aria-current-label="Página actual"
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
                field="name_unit"
                label="Nombre Unidad"
                sortable
                searchable
              >

                <template v-slot="props">
                <a href="#" type="is-info" @click="Clickshowunit(props.row.id)">{{ props.row.name_unit }}</a>
           
                </template>
              </b-table-column>

              <b-table-column
                field="description_unit"
                label="Descripción"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.description_unit }}
                </template>
              </b-table-column>

              <b-table-column
                field="identification_number_unit"
                label="N° Identificación"
                sortable
                searchable>

                <template v-slot="props">
                  {{ props.row.identification_number_unit }}
                </template>
              </b-table-column>





              <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                   <b-tooltip label="Ver detalle" type="is-info">
                <b-icon pack="fas" icon="eye" size="is-medium"
              @click.native="Clickshowunit(props.row.id)"/>
              </b-tooltip>
                  </div>

                  <div class="column">
                    <b-tooltip label="Anular" type="is-info">
                      <b-icon pack="fas" icon="trash" size="is-medium"
                        @click.native="confirmisempty(props.row.id)" />
                    </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Editar" type="is-info">
                      <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editUnit(props.row.id)" />
                    </b-tooltip>
                  </div>
                </div>



              </b-table-column>


            </b-table>
          </div>
         </b-tab-item>

        <b-tab-item label="Unidades en papelera">
            <div class="center">
            <h1>Unidades en papelera</h1>
          </div>

          <div class="column">
            <b-table
              id="table"
              :data="null_units"
              :paginated="true"
              per-page="8"
              striped
              hoverable
              :pagination-simple="false"
              pagination-active-color="hsl(0, 0%, 0%)"
              pagination-position="bottom"
              default-sort-direction="asc"
              sort-icon="arrow-up"
              aria-next-label="Siguiente"
              aria-previous-label="Anterior"
              aria-page-label="Página"
              aria-current-label="Página actual"
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
                field="name_unit"
                label="Nombre Unidad"
                sortable
                searchable
              >

                <template v-slot="props">
                <a href="#" type="is-info" @click="Clickshowunit(props.row.id)">{{ props.row.name_unit }}</a>
           
                </template>
              </b-table-column>

              <b-table-column
                field="description_unit"
                label="Descripción"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.description_unit }}
                </template>
              </b-table-column>

              <b-table-column
                field="identification_number_unit"
                label="N° Identificación"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.identification_number_unit }}
                </template>
              </b-table-column>





              <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                   <b-tooltip label="Ver detalle" type="is-info">
                <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowunit(props.row.id)"/>
              </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Restaurar" type="is-info">
                      <b-icon pack="fas" icon="trash-arrow-up" size="is-medium"
                        @click.native="confirmGoodRest(props.row.id)" />
                    </b-tooltip>
                  </div>
                </div> 
              </b-table-column>




            </b-table>
          </div>

        </b-tab-item>    
      </b-tabs>
    </div>
  </section>
</template>


<script>
import axios from "axios";
import NewUnit from "./new_unit.vue";
import EditUnit from "./edit_unit.vue";
import ShowUnit from "./show_unit.vue";
import exportXlsFile from "export-from-json";
export default {
  data() {
    return {
      units: [],
      null_units: [],
      canCancel: ["escape"],
      managers: [],
      goods: [],
      offices_unit: [],
      buildings_unit: [],
      isModalActive: false,
      isModalActiveShow: false,
      isModalActiveEdit: false,
      selected: null,
      continue: false,
      null_active: 0,
      des_active: 1,
      pendiing_good: 2,
    };
  },
  components: {
    NewUnit,
    ShowUnit,
    EditUnit,
  },
  props: ["unitId"],
  methods: {

    
        downloaddocument(){
          const data = this.units;
          const filename = 'Unidades';
          const exportType = exportXlsFile.types.xls;
          exportXlsFile({data, filename, exportType})

        },

        async getunitactive() {
      const response = await axios.get("/units/showactiveunit.json");
      this.units = response.data;
    },

        async null_getunit() {
      const response = await axios.get("/units/shownullunit.json");
      this.null_units = response.data;
    },

    async RestClick(item) {
      const response = await axios.put("/units/" + item + ".json", {
        active_unit: this.des_active,
      });
      window.location.href = "/units";
    },
    confirmGoodRest(item) {
      this.$buefy.dialog.confirm({
        title: "Restaurar Unidad",
        message: "¿Esta seguro de querer restaurar la Unidad?.",
        confirmText: "Restaurar",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.RestClick(item),
      });
    },

    confirmisempty(item){
      this.getdutymanagerbyunit(item);
    },

    confirmGoodNull(item) {
        this.$buefy.dialog.confirm({
        title: "Anular Unidad",
        message: "¿Esta seguro de querer anular la Unidad?.",
        confirmText: "Anular",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.AnulClick(item),
      });

      
    },

    async Clicknewunit() {
      const response = (window.location.href = "/units/new");
    },
    async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },
    async createUnit() {
      this.isModalActive = true;
    },
    async closeModalCreate() {
      this.isModalActive = false;
    },
    async ShowModaleUnit(item) {
      this.selected = item;
      this.isModalActiveShow = true;
    },
    async closeModalShow() {
      this.isModalActiveShow = false;
    },






         async AnulClick(item) {
      const response = await axios.put("/units/" + item + ".json", {
        active_unit: this.null_active,
      });
      window.location.href = "/units";
    },







    async AnulClickgood(item) {
      const response = await axios.put("/goods/" + item + ".json", {
        activegood: this.pendiing_good,
        
      });
    },
    async AnulClickoffice(item) {
      const response = await axios.put("/offices/" + item + ".json", {
        active_office: this.null_active,
      });
    },
    async AnulClickbuilding(item) {
      const response = await axios.put("/buildings/" + item + ".json", {
        active_building: this.null_active,
      });
    },
    async AnulClickdutymanager(item) {
      const response = await axios.put("/duty_managers/" + item + ".json", {
        active_duty_manager: this.null_active,
      });
    },






    async getdutymanagerbyunit(item) {
      const response = await axios.get(
        "/duty_managers/showdutymanagerunit/" + item + ".json"
      );
      this.managers = response.data;
      console.log(this.managers);
      if (this.managers.length == 0) {
        console.log(this.managers.length);
      this.getgoodbyunit(item);
        
        }
        else{
          this.$buefy.dialog.alert({
                    title: 'No se puede anular',
                    type: 'is-danger',
                    message: 'Existen personas designados a la unidad',
                    confirmText: 'Aceptar'
                })
          //console.log(this.managers.length);
          //this.managerempty= false;
        }

    },

    async getgoodbyunit(item) {
      const response = await axios.get("/goods/showgoodunit/" + item + ".json");
      this.goods = response.data;
      console.log(this.goods);
      if (this.goods.length == 0) {
        console.log(this.goods.length);
        this.getofficebyunit(item);
        }
        else{
          this.$buefy.dialog.alert({
                    title: 'No se puede anular',
                    type: 'is-danger',
                    message: 'Existen bienes designados a la unidad',
                    confirmText: 'Aceptar'
                })
          //console.log(this.goods.length);
          //this.goodsempty= false;
        }
    },

    async getofficebyunit(item) {
      const response = await axios.get("/offices/showofficeunit/" + item + ".json");
      this.offices_unit = response.data;
      console.log(this.offices_unit);
      if (this.offices_unit.length == 0) {
        console.log(this.offices_unit.length);
        this.getbuildingbyunit(item);
        }
        else{
          this.$buefy.dialog.alert({
                    title: 'No se puede anular',
                    type: 'is-danger',
                    message: 'Existen dependencias designados a la unidad',
                    confirmText: 'Aceptar'
                })
          //console.log(this.offices_unit.length);
          //this.officeempty= false;
        }
    },

    async getbuildingbyunit(item) {
      const response = await axios.get("/buildings/showbuildingunit/" + item + ".json");
      this.buildings_unit = response.data;
      console.log(this.buildings_unit);
      if (this.buildings_unit.length == 0) {
        console.log(this.buildings_unit.length);
        this.confirmGoodNull(item);
        }
        else{
          this.$buefy.dialog.alert({
                    title: 'No se puede anular',
                    type: 'is-danger',
                    message: 'Existen edificios designados a la unidad',
                    confirmText: 'Aceptar'
                })
          //console.log(this.buildings_unit.length);
          //this.buildingempty= false;
        }
    },
    async editUnit(item) {
      this.selected = item;
      this.isModalActiveEdit = true;
    },
    async closeModalEdit() {
      this.isModalActiveEdit = false;
    },

  },


  created() {
    this.getunitactive();
    this.null_getunit();
  },

};
</script>


