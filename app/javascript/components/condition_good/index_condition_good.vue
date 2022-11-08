<template>
  <section class="b-tooltips">
    <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px">
      <h1>Bienes dados de baja</h1>

      <div>
        <b-modal :active="isModalActiveShow" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
          width="100%" :can-cancel="canCancel">
          <template>
            <show-condition-good modal-cancel="true" :id="selected" :modal-header="'Detalle del estado'"
              @close="closeModalShow"></show-condition-good>
          </template>
        </b-modal>


        <b-modal :active="isModalnewstatus" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
          width="100%" :can-cancel="canCancel">
          <template>
            <new-condition-good modal-cancel="true" :modal-header="'Cambiar el estado del bien'" query-type="create"
              @close="closeModalCreateStatus"></new-condition-good>
          </template>
        </b-modal>

                <b-modal :active="isModalActiveEdit" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
          width="100%" :can-cancel="canCancel">
          <template>
            <edit-condition-good :condition_good-id="condition_goodId" :id="selected" :modal-header="'Editar Estado del bien'" query-type="update"
              @close="closeModalEdit"></edit-condition-good>
          </template>
        </b-modal>


      </div>






        <b-tabs type="is-boxed" position="is-centered">
        <b-tab-item label="Bienes a dar de baja">
          <div class="has-text-right">
            <b-button label="Añadir Estado" type="is-info" icon-left="plus" @click="createConditionGood()"></b-button>
          </div>
          <div class="center">
            <h1>Bienes a dar de baja</h1>
          </div>
          <br />

          <div class="column">

            <b-table :data="request" striped hoverable :paginated="true" per-page="8" :pagination-simple="false"
              pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up">
              <b-table-column :visible="false" field="id" label="ID" sortable searchable>
                <!-- Comment -->

                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>



              <b-table-column field="good_id" label="ID del bien" sortable searchable>
                <template v-slot="props">
                  <a>{{ props.row.good_id }}</a>
                </template>
              </b-table-column>



              <b-table-column field="good.namegood" label="Nombre del bien" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.namegood }}</a>
                </template>
              </b-table-column>

              <b-table-column field="good.name_office" label="Nombre de la oficina" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.name_office }}</a>
                </template>
              </b-table-column>

              <b-table-column field="good.name_building" label="Nombre del edificio" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.name_building }}</a>
                </template>
              </b-table-column>

              <b-table-column field="good.name_duty_manager" label="Persona encargada" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.name_duty_manager }}</a>
                </template>
              </b-table-column>

              <b-table-column field="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                    <b-tooltip label="Ver detalle" type="is-info">
                      <b-icon pack="fas" icon="eye" size="is-medium"
                        @click.native="Clickshowconditiongood(props.row.id)" />
                    </b-tooltip>
                  </div>

                                   <div class="column">
                    <b-tooltip label="Aceptar" type="is-info">
                      <b-icon pack="fas" icon="check" size="is-medium"
                        @click.native="confirmRequest(props.row.id,props.row.good_id)" />
                    </b-tooltip>
                  </div>

                  <div class="column">
                    <b-tooltip label="Editar" type="is-info">
                      <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editGood(props.row.id)" />
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







      
        <b-tab-item label="Bienes en bodega">
          <div class="has-text-right">
            <b-button label="Añadir Estado" type="is-info" icon-left="plus" @click="createConditionGood()"></b-button>
          </div>
          <div class="center">
            <h1>Bienes en Bodega</h1>
          </div>
          <div class="columns"></div>
          <br />
          <div class="column">
            <b-table :data="excluded" striped hoverable :paginated="true" per-page="8" :pagination-simple="false"
              pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up">
              <b-table-column :visible="false" field="id" label="ID" sortable searchable>
                <!-- Comment -->

                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>

              <b-table-column field="good.namegood" label="Nombre del bien" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.namegood }}</a>
                </template>
              </b-table-column>




              <b-table-column field="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                    <b-tooltip label="Ver detalle" type="is-info">
                      <b-icon pack="fas" icon="eye" size="is-medium"
                        @click.native="Clickshowconditiongood(props.row.id)" />
                    </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Editar" type="is-info">
                      <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editGood(props.row.id)" />
                    </b-tooltip>
                  </div>
                </div>
              </b-table-column>

            </b-table>
          </div>
        </b-tab-item>







        <b-tab-item label="Bienes Perdidos">

          <div class="has-text-right">
            <b-button label="Añadir Estado" type="is-info" icon-left="plus" @click="createConditionGood()"></b-button>
          </div>
          <div class="center">
            <h1>Bienes Perdidos</h1>
          </div>
          <div class="columns"></div>
          <br />
          <div class="column">
            <b-table :data="lost" striped hoverable :paginated="true" per-page="8" :pagination-simple="false"
              pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up">
              <b-table-column :visible="false" field="id" label="ID" sortable searchable>

                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>

              <b-table-column field="good.namegood" label="Nombre del bien" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.namegood }}</a>
                </template>
              </b-table-column>

              <b-table-column field="good.name_office" label="Nombre de la oficina" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.name_office }}</a>
                </template>
              </b-table-column>

              <b-table-column field="good.name_building" label="Nombre del edificio" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.name_building }}</a>
                </template>
              </b-table-column>

              <b-table-column field="good.name_duty_manager" label="Persona encargada" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.name_duty_manager }}</a>
                </template>
              </b-table-column>
 
              <b-table-column field="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                    <b-tooltip label="Ver detalle" type="is-info">
                      <b-icon pack="fas" icon="eye" size="is-medium"
                        @click.native="Clickshowconditiongood(props.row.id)" />
                    </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Editar" type="is-info">
                      <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editGood(props.row.id)" />
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






        <b-tab-item label="Bienes Destruidos">
          <div class="has-text-right">
            <b-button label="Añadir Estado" type="is-info" icon-left="plus" @click="createConditionGood()"></b-button>
          </div>
          <div class="center">
            <h1>Bienes Destruidos</h1>
          </div>
          <div class="columns"></div>
          <br />
          <div class="column">
            <b-table :data="destroyed" striped hoverable :paginated="true" per-page="8" :pagination-simple="false"
              pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up">
              <b-table-column :visible="false" field="id" label="ID" sortable searchable>

                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>
              <b-table-column field="good.namegood" label="Nombre del bien" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.namegood }}</a>
                </template>
              </b-table-column>
              <b-table-column field="good.name_office" label="Nombre de la oficina" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.name_office }}</a>
                </template>
              </b-table-column>

              <b-table-column field="good.name_building" label="Nombre del edificio" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.name_building }}</a>
                </template>
              </b-table-column>

              <b-table-column field="good.name_duty_manager" label="Persona encargada" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.name_duty_manager }}</a>
                </template>
              </b-table-column>

              <b-table-column field="repairable" label="¿Se puede reparar?" sortable searchable>
                <template v-slot="props">
                  {{ props.row.repairable }}
                </template>
              </b-table-column>
              <b-table-column field="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                    <b-tooltip label="Ver detalle" type="is-info">
                      <b-icon pack="fas" icon="eye" size="is-medium"
                        @click.native="Clickshowconditiongood(props.row.id)" />
                    </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Editar" type="is-info">
                      <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editGood(props.row.id)" />
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








           <b-tab-item label="Bajas en papelera">
          <div class="center">
            <h1>Bajas en papelera</h1>
          </div>
          <div class="column">
            <b-table :data="null_goods_condition" :paginated="true" per-page="8" striped hoverable :pagination-simple="false"
              pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up" sort-icon-size="is-small"
              type="is-info">



 <b-table-column :visible="false" field="id" label="ID" sortable searchable>

                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>
              <b-table-column field="good.namegood" label="Nombre del bien" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.namegood }}</a>
                </template>
              </b-table-column>



              <b-table-column field="condition.state_name" label="Estado" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.condition.state_name }}</a>
                </template>
              </b-table-column>



              <b-table-column field="good.name_office" label="Nombre de la oficina" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.name_office }}</a>
                </template>
              </b-table-column>


              <b-table-column field="good.name_duty_manager" label="Persona encargada" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="ShowModalConditionGood(props.row.id)">{{ props.row.good.name_duty_manager }}</a>
                </template>
              </b-table-column>
              <b-table-column field="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                    <b-tooltip label="Ver detalle" type="is-info">
                      <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowconditiongood(props.row.id)" />
                    </b-tooltip>
                  </div>
                  <div class="column" v-show='!(props.row.condition_id == 2)'>
                    <b-tooltip label="Restaurar" type="is-info">
                      <b-icon pack="fas" icon="trash-arrow-up" size="is-medium"
                        @click.native="confirmGoodRest(props.row.id)" />
                    </b-tooltip>
                  </div>

                  <div class="column" v-show='(props.row.condition_id == 2)'> 
                    <b-tooltip label="No  se puede Restaurar" type="is-info">
                      <b-icon pack="fas" icon="trash-arrow-up" type="is-danger" size="is-medium"/>
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
import NewConditionGood from "./new_condition_good.vue";
import ShowConditionGood from "./show_condition_good.vue";
import EditConditionGood from "./edit_condition_good.vue";

export default {
  data() {
    return {
      goods: [],
      null_goods_condition: [],
      offices: [],
      units: [],
      managers: [],
      buildings: [],
      request: [],
      excluded: [],
      lost: [],
      destroyed: [],
      isFullPage: true,
      selected: null,
      canCancel: ["escape"],
      isModalnewstatus: false,
      isModalActiveEdit: false,
      isModalActiveShow: false,
      aux_duty_manager_id: null,
      aux_date_entry: new Date(),
      aux_office_id: null,
      aux_unit_id: null,
      aux_building_id: null,
      acept: 2,
      null_activegood: 0,
      des_activegood: 1,
      good_decommissioned: 3,
    };
  },
  props: ["id", 'queryType', 'modalHeader', 'goodId', 'condition_goodId'],

  components: {
    NewConditionGood,
    ShowConditionGood,
    EditConditionGood,
  },

  methods: { 

    async getrequest() {
      const response = await axios.get("/condition_goods/showrequest.json");
      this.request = response.data;
    },

    async getexcluded() {
      const response = await axios.get("/condition_goods/showexcluded.json");
      this.excluded = response.data;
    },
    async getlost() {
      const response = await axios.get("/condition_goods/showlost.json");
      this.lost = response.data;
    },
    async getdestroyed() {
      const response = await axios.get("/condition_goods/showdestroyed.json");
      this.destroyed = response.data;
    },


    async getgoodsactive() {
      const response = await axios.get("/goods/showactive.json");
      this.goods = response.data;
    },

    async null_getgoods() {
      const response = await axios.get("/condition_goods/showconditionnull.json");
      this.null_goods_condition = response.data;
    },

    async Clickshowgood(item) {
      const response = (window.location.href = "/goods/" + item);
    },
    async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item);
    },
    async Clickshowbuilding(item) {
      const response = (window.location.href = "/buildings/" + item);
    },
    async Clickshowoffice(item) {
      const response = (window.location.href = "/offices/" + item);
    },





    async AnulClick(item) {
      const response = await axios.put("/condition_goods/" + item + ".json", {
        activeconditiongood: this.null_activegood,
      });
      window.location.href = "/condition_goods";
    },

    async RestClick(item) {
      const response = await axios.put("/condition_goods/" + item + ".json", {
        activeconditiongood: this.des_activegood,
      });
      window.location.href = "/condition_goods";
    },
    confirmGoodRest(item) {
      this.$buefy.dialog.confirm({
        title: "Restaurar Bien",
        message: "¿Esta seguro de querer restaurar la baja del bien?.",
        confirmText: "Restaurar",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.RestClick(item),
      });
    },

    confirmGoodNull(item) {
      this.$buefy.dialog.confirm({
        title: "Anular Bien",
        message: "¿Esta seguro de querer anular la baja del bien?.",
        confirmText: "Anular",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.AnulClick(item),
      });
    },

        async getunitactive() {
      const response = await axios.get("/units/showactiveunit.json");
      this.units = response.data;
    },

    async getdutymanagerbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/duty_managers/showdutymanagerunit/" +
        item +
        ".json"
      );
      this.managers = response.data;
    },

    async getbuildingbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/buildings/showbuildingunit/" + item + ".json"
      );
      this.buildings = response.data;
    },

    async getofficebybuilding(item) {
      const response = await axios.get(
        "http://localhost:3000/offices/showofficebuilding/" + item + ".json"
      );
      this.offices = response.data;
    },

  async Clickshowconditiongood(item) {
      const response = (window.location.href = "/condition_goods/" + item);
    },


    async newReport() {
      const response = (window.location.href = "/condition_goods/new");

    },

    async createConditionGood() {
      this.isModalnewstatus = true;
    },

    async closeModalCreateStatus() {
      this.isModalnewstatus = false;
    },


    async ShowModalConditionGood(item) {
      this.selected = item;
      this.isModalActiveShow = true;
    },
    async closeModalShow() {
      this.isModalActiveShow = false;
    },

    async editGood(item) {
      this.selected = item;
      this.isModalActiveEdit = true;
    },
    async closeModalEdit() {
      this.isModalActiveEdit = false;
    },

        confirmRequest(item,item_2) {
      this.$buefy.dialog.confirm({
        title: "Confirmar solicitud",
        message: "¿Esta seguro de querer aceptar la solicitud?.",
        confirmText: "Aceptar",
        cancelText: "Cancelar",
        type: "is-info",
        hasIcon: true,
        onConfirm: () => this.aceptrequest(item,item_2),
      });},

        async aceptrequest(item,item_2) {
      const response = await axios.put("/condition_goods/" + item + ".json", {
        date_entry: this.aux_date_entry,
        condition_id: this.acept,});
        this.goodtodecommissioned(item_2);
        window.location.href = "/condition_goods";
    },

        async goodtodecommissioned(item) {
      const response = await axios.put("/goods/" + item + ".json", {
        activegood: this.good_decommissioned,
      });
      
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

                open() {
                const loadingComponent = this.$buefy.loading.open({
                    container: this.isFullPage ? null : this.$refs.element.$el
                })
                setTimeout(() => loadingComponent.close(), 3 * 1000)
            }

  },
  created() {
    this.getrequest();
    this.getexcluded();
    this.getlost();
    this.getdestroyed();
    this.getgoodsactive();
    this.null_getgoods();
    this.getunitactive();
  },
};
</script>
