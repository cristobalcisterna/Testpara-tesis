<template>
  <section class="b-tooltips"> 
    <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px;">
      <h1>Dependencias de la facultad</h1>
      <b-tabs>
        <b-tab-item label="Dependencias de la facultad">
                    <div class="center">
            <h1>Dependencias</h1>
          </div>
                     <div class="has-text-right">
              <b-button
                label="Añadir dependencia"
                type="is-info"
                icon-left="plus"
                @click="createOffice()"
              ></b-button>
            </div>
 
            <div>
                  <b-modal
          :active="isModalActive"
          aria-modal
          has-modal-card
          :destroy-on-hide="true"
          aria-role="dialog"
          width="100%"
          :can-cancel="canCancel">
        <template>
          <new-office modal-cancel="true"
                            :modal-header="'Registro de Dependencia'"
                            query-type="create"
                            @close="closeModalCreate"></new-office>
        </template>
      </b-modal>

       <b-modal :active="isModalActiveEdit" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <edit-office :office-id="officeId" :id="selected" :modal-header="'Editar Dependencia'" query-type="update"
                  @close="closeModalEdit"></edit-office>
              </template>
            </b-modal>

      </div>

          <div class="column">
            <b-table 
            :data="offices"
            :paginated=true 
                per-page="8"
                striped
                hoverable
                :pagination-simple=false
                pagination-position="bottom"
                default-sort-direction="asc" 
                sort-icon="arrow-up"
                sort-icon-size="is-small"
                default-sort="inventores.name"
                aria-next-label="Siguiente"
                aria-previous-label="Anterior"
                aria-page-label="Página"
                aria-current-label="Página actual">
              <b-table-column :visible=false field="id" label="ID" sortable searchable>

                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>

              <b-table-column
                field="name_office"
                label="Nombre dependencia"
                sortable
                searchable
              >

                <template v-slot="props">
                <a href="#" @click="Clickshowoffice(props.row.id)">{{ props.row.name_office }}</a>
                </template>
              </b-table-column>

              <b-table-column
                field="identification_number_office"
                label="N° Identificación"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.identification_number_office }}
                </template>
              </b-table-column>

              <b-table-column
                field="building.name_building"
                label="Edificio"
                sortable
                searchable
              >

                <template v-slot="props">
                <a href="#" @click="Clickshowbuilding(props.row.building_id)">{{ props.row.building.name_building }}</a>
            
                </template>
              </b-table-column>

              <b-table-column
                field="location"
                label="Ubicación"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.location }}
                </template>
              </b-table-column>


                           <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">

                <div class="columns">
                  <div class="column">
                   <b-tooltip label="Ver detalle" type="is-info">
                <b-icon
              pack="fas"
              icon="eye"
              size="is-medium"
              @click.native="Clickshowoffice(props.row.id)"/>
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
                      <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editOffice(props.row.id)" />
                    </b-tooltip>
                  </div>
                </div>
              </b-table-column>
            </b-table>
          </div>
        </b-tab-item>



        <b-tab-item label="Dependencias en papelera">
          <div class="center">
            <h1>Dependencias en papelera</h1>
          </div>

          <div class="column">
            <b-table 
            :data="null_offices"
            :paginated=true 
                per-page="8"
                striped
                hoverable
                :pagination-simple=false
                pagination-position="bottom"
                default-sort-direction="asc" 
                sort-icon="arrow-up"
                sort-icon-size="is-small"
                default-sort="inventores.name"
                aria-next-label="Siguiente"
                aria-previous-label="Anterior"
                aria-page-label="Página"
                aria-current-label="Página actual">
              <b-table-column :visible=false field="id" label="ID" sortable searchable>

                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>

              <b-table-column
                field="name_office"
                label="Nombre dependencia"
                sortable
                searchable
              >

                <template v-slot="props">
                <a href="#" @click="Clickshowoffice(props.row.id)">{{ props.row.name_office }}</a>
                </template>
              </b-table-column>

              <b-table-column
                field="identification_number_office"
                label="N° Identificación"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.identification_number_office }}
                </template>
              </b-table-column>



              <b-table-column
                field="building.name_building"
                label="Edificio"
                sortable
                searchable
              >

                <template v-slot="props">
                <a href="#" @click="Clickshowbuilding(props.row.building_id)">{{ props.row.building.name_building }}</a>
            
                </template>
              </b-table-column>

              <b-table-column
                field="location"
                label="Ubicación"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.location }}
                </template>
              </b-table-column>

                <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">

                <div class="columns">
                  <div class="column">
                   <b-tooltip label="Ver detalle" type="is-info">
                <b-icon
              pack="fas"
              icon="eye"
              size="is-medium"
              @click.native="Clickshowoffice(props.row.id)"/>
              </b-tooltip>
                  </div>
                  <div class="column" v-show='!(props.row.building.active_building == 0)'>
                    <b-tooltip label="Restaurar" type="is-info">
                      <b-icon pack="fas" icon="trash-arrow-up" size="is-medium"
                        @click.native="confirmGoodRest(props.row.id)" />
                    </b-tooltip>
                  </div>

                  <div class="column" v-show='(props.row.building.active_building == 0)'> 
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
import NewOffice from './new_office.vue';
import ShowOffice from './show_office.vue';
import EditOffice from "./edit_office.vue";
export default { 

  data() {
    return {
      offices: [],
      goods: [],
      goods_office: [],
      id_goods_list: [],
      null_offices: [],
      canCancel: ["escape"],
      isModalActive: false,
      isModalActiveShow: false,
      isModalActiveEdit: false,
      selected: null,
      null_active: 0,
      des_active: 1,
      pendiing_good: 2,
    };
  },
    components: { NewOffice, ShowOffice, EditOffice },
    props: ["officeId"],
  methods: {


        async getoffices() {
      const response = await axios.get("/offices/showactiveoffice.json");
      this.offices = response.data;
    },

        async null_getunit() {
      const response = await axios.get("/offices/shownulloffice.json");
      this.null_offices = response.data;
    },


    async RestClick(item) {
      const response = await axios.put("/offices/" + item + ".json", {
        active_office: this.des_active,
      });
      window.location.href = "/offices";
    },
    confirmGoodRest(item) {
      this.$buefy.dialog.confirm({
        title: "Restaurar Dependencia",
        message: "¿Esta seguro de querer restaurar la Dependencia?.",
        confirmText: "Restaurar",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.RestClick(item),
      });
    },

 

        async confirmisempty(item) {
      const response = await axios.get("/goods/showgoodoffice/" + item + ".json");
      this.goods_office = response.data;
      console.log(this.goods_office);
      if (this.goods_office.length == 0) {
        console.log(this.goods_office.length);
        this.confirmGoodNull(item);
        }
        else{
          this.$buefy.dialog.alert({
                    title: 'No se puede anular',
                    type: 'is-danger',
                    message: 'Existen bienes designados en el edificio',
                    confirmText: 'Aceptar'
                })
        }
    },

    confirmGoodNull(item) {
      this.$buefy.dialog.confirm({
        title: "Anular Dependencia",
        message: "¿Esta seguro de querer anular la Dependencia?.",
        confirmText: "Anular",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.AnulClick(item),
      });
    },


         async AnulClick(item) {
      const response = await axios.put("/offices/" + item + ".json", {
        active_office: this.null_active,
      });
      window.location.href = "/offices";
    },




        async getgoodbyoffice(item) {
      const response = await axios.get("/goods/showgoodoffice/" + item + ".json");
      this.goods = response.data;
      
    },








     async Clicknewoffice() {
      const response = (window.location.href = "/offices/new");
    },
    async Clickshowoffice(item) {
      const response = (window.location.href = "/offices/" + item );
    },
     async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },
      async Clickshowgood(item) {
      const response = (window.location.href = "/goods/" + item);
      console.log(this.item);
    },
        async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item );
    },
            async Clickshowbuilding(item) {
      const response = (window.location.href = "/buildings/" + item );
    },
    async createOffice(){
      this.isModalActive = true;
    },
    async closeModalCreate(){
      this.isModalActive = false;
    },
        async ShowModalOffice(item) {
      this.selected = item;
      this.isModalActiveShow = true;
    },
    async closeModalShow() {
      this.isModalActiveShow = false;
    },

    async editOffice(item) {
      this.selected = item;
      this.isModalActiveEdit = true;
    },
    async closeModalEdit() {
      this.isModalActiveEdit = false;
    },

  },
  created() {
    this.getoffices();
    this.null_getunit();
  },
};
</script>